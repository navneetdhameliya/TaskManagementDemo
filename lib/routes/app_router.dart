import 'package:flutter/material.dart';
import 'package:task_manager/page_not_found.dart';
import 'package:task_manager/routes/pages.dart';
import 'package:task_manager/data/local/model/task_model.dart';
import 'package:task_manager/presentation/pages/new_task_screen.dart';
import 'package:task_manager/presentation/pages/tasks_screen.dart';
import 'package:task_manager/presentation/pages/update_task_screen.dart';

Route pageRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Routes.initial:
      return MaterialPageRoute(
        builder: (context) => const TasksScreen(),
      );
    case Routes.createNewTask:
      return MaterialPageRoute(
        builder: (context) => const NewTaskScreen(),
      );
    case Routes.updateTask:
      final args = routeSettings.arguments as TaskDataModel;
      return MaterialPageRoute(
        builder: (context) => UpdateTaskScreen(taskModel: args),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const PageNotFound(),
      );
  }
}
