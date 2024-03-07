import 'package:task_manager/data/local/data_sources/tasks_data_provider.dart';
import 'package:task_manager/data/local/model/task_model.dart';

class TaskRepository{
  final TaskDataProvider taskDataProvider;

  TaskRepository({required this.taskDataProvider});

  Future<List<TaskDataModel>> getTasks() async {
    return await taskDataProvider.getTasks();
  }

  Future<void> createNewTask(TaskDataModel taskModel) async {
    return await taskDataProvider.createTask(taskModel);
  }

  Future<List<TaskDataModel>> updateTask(TaskDataModel taskModel) async {
    return await taskDataProvider.updateTask(taskModel);
  }

  Future<List<TaskDataModel>> deleteTask(TaskDataModel taskModel) async {
    return await taskDataProvider.deleteTask(taskModel);
  }

  Future<List<TaskDataModel>> searchTasks(String search) async {
    return await taskDataProvider.searchTasks(search);
  }

}