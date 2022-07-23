import 'dart:async';

import 'package:bloc_todo_app/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage_todos_api/local_storage_todos_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_repository/todos_repository.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.clear();

  final todosApi =
      LocalStorageTodosApi(plugin: await SharedPreferences.getInstance());

  final todosRepository = TodosRepository(todosApi: todosApi);

  await BlocOverrides.runZoned(() async => runApp(App(
        todosRepository: todosRepository,
      )));
}
