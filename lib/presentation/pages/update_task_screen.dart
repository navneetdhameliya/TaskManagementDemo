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

class UpdateTaskScreen extends StatefulWidget {
  final TaskDataModel taskModel;

  const UpdateTaskScreen({super.key, required this.taskModel});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  void initState() {
    title.text = widget.taskModel.title;
    description.text = widget.taskModel.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: ColorConstants.whiteColor,
        appBar: const CustomAppBar(
          title: AppConstants.updateTask,
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<TasksBloc, TasksState>(
              listener: (context, state) {
                if (state is UpdateTaskFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      getSnackBar(state.error, ColorConstants.red));
                }
                if (state is UpdateTaskSuccess) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return ListView(
                  children: [
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
                    SizedBox(
                      width: size.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ColorConstants.primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () {
                          var taskModel = TaskDataModel(
                            id: widget.taskModel.id,
                            title: title.text,
                            description: description.text,
                            completed: widget.taskModel.completed,
                          );
                          context
                              .read<TasksBloc>()
                              .add(UpdateTaskEvent(taskModel: taskModel));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: buildText(
                              AppConstants.update,
                              ColorConstants.whiteColor,
                              14,
                              FontWeight.w600,
                              TextAlign.center,
                              TextOverflow.clip),
                        ),
                      ),
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
