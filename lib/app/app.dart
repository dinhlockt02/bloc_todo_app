import 'package:bloc_todo_app/home/view/home_page.dart';
import 'package:bloc_todo_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repository/todos_repository.dart';

class App extends StatelessWidget {
  const App({Key? key, required TodosRepository todosRepository})
      : _todosRepository = todosRepository,
        super(key: key);

  final TodosRepository _todosRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _todosRepository,
      child: AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlutterTodosTheme.light,
      darkTheme: FlutterTodosTheme.dark,
      home: HomePage(),
    );
  }
}
