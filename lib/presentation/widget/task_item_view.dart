import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/components/widgets.dart';
import 'package:task_manager/data/local/model/task_model.dart';
import 'package:task_manager/routes/pages.dart';
import 'package:task_manager/utils/color_constants.dart';
import 'package:task_manager/utils/image_constants.dart';
import '../bloc/tasks_bloc.dart';

class TaskItemView extends StatefulWidget {
  final TaskDataModel taskModel;

  const TaskItemView({super.key, required this.taskModel});

  @override
  State<TaskItemView> createState() => _TaskItemViewState();
}

class _TaskItemViewState extends State<TaskItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
                value: widget.taskModel.completed,
                onChanged: (value) {
                  var taskModel = TaskDataModel(
                    id: widget.taskModel.id,
                    title: widget.taskModel.title,
                    description: widget.taskModel.description,
                    completed: !widget.taskModel.completed,
                  );
                  context
                      .read<TasksBloc>()
                      .add(UpdateTaskEvent(taskModel: taskModel));
                }),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: buildText(
                              widget.taskModel.title,
                              ColorConstants.blackColor,
                              14,
                              FontWeight.w500,
                              TextAlign.start,
                              TextOverflow.clip)),
                      PopupMenuButton<int>(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: ColorConstants.whiteColor,
                        elevation: 1,
                        onSelected: (value) {
                          switch (value) {
                            case 0:
                              {
                                Navigator.pushNamed(context, Routes.updateTask,
                                    arguments: widget.taskModel);
                                break;
                              }
                            case 1:
                              {
                                context.read<TasksBloc>().add(DeleteTaskEvent(
                                    taskModel: widget.taskModel));
                                break;
                              }
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<int>(
                              value: 0,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageConstants.editIcon,
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildText(
                                      'Edit task',
                                      ColorConstants.blackColor,
                                      14,
                                      FontWeight.normal,
                                      TextAlign.start,
                                      TextOverflow.clip)
                                ],
                              ),
                            ),
                            PopupMenuItem<int>(
                              value: 1,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageConstants.deleteIcon,
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildText(
                                      'Delete task',
                                      ColorConstants.red,
                                      14,
                                      FontWeight.normal,
                                      TextAlign.start,
                                      TextOverflow.clip)
                                ],
                              ),
                            ),
                          ];
                        },
                        child:
                            SvgPicture.asset(ImageConstants.verticalMenuIcon),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  buildText(widget.taskModel.description, ColorConstants.grey500, 12,
                      FontWeight.normal, TextAlign.start, TextOverflow.clip),
                ],
              ),
            ),
          ],
        ));
  }
}
