import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/local/data_sources/tasks_data_provider.dart';
import 'package:task_manager/data/repository/task_repository.dart';
import 'package:task_manager/routes/app_router.dart';
import 'package:task_manager/routes/pages.dart';
import 'package:task_manager/presentation/bloc/tasks_bloc.dart';
import 'package:task_manager/utils/app_constants.dart';
import 'package:task_manager/utils/color_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(MyApp(
    preferences: preferences,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences preferences;

  const MyApp({super.key, required this.preferences});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) =>
          TaskRepository(taskDataProvider: TaskDataProvider(preferences)),
      child: BlocProvider(
        create: (context) => TasksBloc(context.read<TaskRepository>()),
        child: MaterialApp(
          title: AppConstants.taskManager,
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.initial,
          onGenerateRoute: pageRoute,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.primaryColor),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}
