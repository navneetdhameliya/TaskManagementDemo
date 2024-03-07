import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/components/build_text_field.dart';
import 'package:task_manager/components/custom_app_bar.dart';
import 'package:task_manager/components/widgets.dart';
import 'package:task_manager/data/local/model/task_model.dart';
import 'package:task_manager/presentation/bloc/tasks_bloc.dart';
import 'package:task_manager/utils/app_constants.dart';
import 'package:task_manager/utils/color_constants.dart';
import 'package:task_manager/utils/util.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: ColorConstants.whiteColor,
        appBar: const CustomAppBar(
          title: AppConstants.createNewTask,
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<TasksBloc, TasksState>(
              listener: (context, state) {
                if (state is AddTaskFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      getSnackBar(state.error, ColorConstants.red));
                }
                if (state is AddTasksSuccess) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return ListView(
                  children: [
                    const SizedBox(height: 20),
                    buildText(
                        AppConstants.title,
                        ColorConstants.blackColor,
                        14,
                        FontWeight.bold,
                        TextAlign.start,
                        TextOverflow.clip),
                    const SizedBox(
                      height: 10,
                    ),
                    BuildTextField(
                        hintText: AppConstants.taskTitle,
                        textEditingController: title,
                        inputType: TextInputType.text,
                        fillColor: ColorConstants.whiteColor,
                        onChange: (value) {}),
                    const SizedBox(
                      height: 20,
                    ),
                    buildText(
                        AppConstants.description,
                        ColorConstants.blackColor,
                        14,
                        FontWeight.bold,
                        TextAlign.start,
                        TextOverflow.clip),
                    const SizedBox(
                      height: 10,
                    ),
                    BuildTextField(
                        hintText: AppConstants.taskDescription,
                        textEditingController: description,
                        inputType: TextInputType.multiline,
                        fillColor: ColorConstants.whiteColor,
                        onChange: (value) {}),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  ColorConstants.whiteColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: buildText(
                                  AppConstants.cancel,
                                  ColorConstants.blackColor,
                                  14,
                                  FontWeight.w600,
                                  TextAlign.center,
                                  TextOverflow.clip),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  ColorConstants.primaryColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              final String taskId = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();
                              var taskModel = TaskDataModel(
                                id: taskId,
                                title: title.text,
                                description: description.text,
                              );
                              context
                                  .read<TasksBloc>()
                                  .add(AddNewTaskEvent(taskModel: taskModel));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: buildText(
                                  AppConstants.create,
                                  ColorConstants.whiteColor,
                                  14,
                                  FontWeight.w600,
                                  TextAlign.center,
                                  TextOverflow.clip),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
