import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/components/custom_app_bar.dart';
import 'package:task_manager/components/widgets.dart';
import 'package:task_manager/presentation/bloc/tasks_bloc.dart';
import 'package:task_manager/components/build_text_field.dart';
import 'package:task_manager/presentation/widget/task_item_view.dart';
import 'package:task_manager/routes/pages.dart';
import 'package:task_manager/utils/app_constants.dart';
import 'package:task_manager/utils/color_constants.dart';
import 'package:task_manager/utils/util.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<TasksBloc>().add(FetchTaskEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: ScaffoldMessenger(
        child: Scaffold(
          backgroundColor: ColorConstants.whiteColor,
          appBar: const CustomAppBar(
            title: AppConstants.hiText,
            showBackButton: false,
          ),
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: BlocConsumer<TasksBloc, TasksState>(
                listener: (context, state) {
                  if (state is LoadTaskFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        getSnackBar(state.error, ColorConstants.red));
                  }

                  if (state is AddTaskFailure || state is UpdateTaskFailure) {
                    context.read<TasksBloc>().add(FetchTaskEvent());
                  }
                },
                builder: (context, state) {
                  if (state is TasksLoading) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }

                  if (state is LoadTaskFailure) {
                    return Center(
                      child: buildText(
                          state.error,
                          ColorConstants.blackColor,
                          14,
                          FontWeight.normal,
                          TextAlign.center,
                          TextOverflow.clip),
                    );
                  }

                  if (state is FetchTasksSuccess) {
                    return state.tasks.isNotEmpty || state.isSearching
                        ? Column(
                            children: [
                              BuildTextField(
                                hintText: AppConstants.searchTask,
                                textEditingController: searchController,
                                inputType: TextInputType.text,
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: ColorConstants.grey300,
                                ),
                                fillColor: ColorConstants.whiteColor,
                                onChange: (value) {
                                  context
                                      .read<TasksBloc>()
                                      .add(SearchTaskEvent(keywords: value));
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: state.tasks.length,
                                  itemBuilder: (context, index) {
                                    return TaskItemView(
                                        taskModel: state.tasks[index]);
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider(
                                      color: ColorConstants.grey200,
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildText(
                                    'Oops...',
                                    ColorConstants.blackColor,
                                    30,
                                    FontWeight.w600,
                                    TextAlign.center,
                                    TextOverflow.clip),
                                buildText(
                                    'You dont have any active task.\nClick on plus button to create new task',
                                    ColorConstants.blackColor.withOpacity(.5),
                                    14,
                                    FontWeight.normal,
                                    TextAlign.center,
                                    TextOverflow.clip),
                              ],
                            ),
                          );
                  }
                  return Container();
                },
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            backgroundColor: ColorConstants.primaryColor,
            child: const Icon(
              Icons.add,
              color: ColorConstants.grey200,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.createNewTask);
            },
          ),
        ),
      ),
    );
  }
}
