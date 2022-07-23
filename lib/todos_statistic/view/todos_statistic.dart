import 'package:bloc_todo_app/todos_statistic/bloc/statistic_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repository/todos_repository.dart';

class TodosStatistic extends StatelessWidget {
  const TodosStatistic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todosRepository = context.read<TodosRepository>();

    return BlocProvider(
      create: (_) => StatisticBloc(todosRepository),
      child: TodosStatisticView(),
    );
  }
}

class TodosStatisticView extends StatelessWidget {
  const TodosStatisticView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos Statistic')),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Active Tasks'),
          const SizedBox(
            height: 8,
          ),
          BlocBuilder<StatisticBloc, StatisticState>(
            builder: (context, state) => Text(state.activeCount.toString()),
            buildWhen: (previous, current) =>
                previous.activeCount != current.activeCount,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text('Complete Tasks'),
          const SizedBox(
            height: 8,
          ),
          BlocBuilder<StatisticBloc, StatisticState>(
            builder: (context, state) => Text(state.completeCount.toString()),
            buildWhen: (previous, current) =>
                previous.completeCount != current.completeCount,
          )
        ],
      )),
    );
  }
}
