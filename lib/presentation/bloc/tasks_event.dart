part of 'tasks_bloc.dart';

@immutable
sealed class TasksEvent {}

class AddNewTaskEvent extends TasksEvent {
  final TaskDataModel taskModel;

  AddNewTaskEvent({required this.taskModel});
}

class FetchTaskEvent extends TasksEvent {}

class UpdateTaskEvent extends TasksEvent {
  final TaskDataModel taskModel;

  UpdateTaskEvent({required this.taskModel});
}

class DeleteTaskEvent extends TasksEvent {
  final TaskDataModel taskModel;

  DeleteTaskEvent({required this.taskModel});
}

class SearchTaskEvent extends TasksEvent{
  final String keywords;

  SearchTaskEvent({required this.keywords});
}


