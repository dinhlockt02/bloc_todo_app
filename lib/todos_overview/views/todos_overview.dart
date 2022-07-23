import 'package:bloc_todo_app/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:bloc_todo_app/todos_overview/models/todos_overview_filter.dart';
import 'package:bloc_todo_app/todos_overview/widgets/todo_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repository/todos_repository.dart';

class TodosOverviewPage extends StatelessWidget {
  const TodosOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todosRepository = context.read<TodosRepository>();
    return BlocProvider(
      create: (_) => TodosOverviewBloc(todosRepository),
      child: const TodosOverviewView(),
    );
  }
}

class TodosOverviewView extends StatelessWidget {
  const TodosOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos Overview"),
        centerTitle: false,
        actions: [
          BlocBuilder<TodosOverviewBloc, TodosOverviewState>(
              builder: (_, state) {
            return PopupMenuButton(
              itemBuilder: (ctx) {
                return [
                  PopupMenuItem(
                    child: Text("Show all",
                        style: TextStyle(
                            color: state.filter == TodosOverviewFilter.all
                                ? Theme.of(context).colorScheme.primary
                                : null)),
                    onTap: () {
                      ctx.read<TodosOverviewBloc>().add(
                          const TodosOverViewFilterApplied(
                              filter: TodosOverviewFilter.all));
                    },
                  ),
                  PopupMenuItem(
                    child: Text(
                      "Show active",
                      style: TextStyle(
                          color: state.filter == TodosOverviewFilter.active
                              ? Theme.of(context).colorScheme.primary
                              : null),
                    ),
                    onTap: () {
                      ctx.read<TodosOverviewBloc>().add(
                          const TodosOverViewFilterApplied(
                              filter: TodosOverviewFilter.active));
                    },
                  ),
                  PopupMenuItem(
                    child: Text("Show completed",
                        style: TextStyle(
                            color: state.filter ==
                                    TodosOverviewFilter.completedOnly
                                ? Theme.of(context).colorScheme.primary
                                : null)),
                    onTap: () {
                      ctx.read<TodosOverviewBloc>().add(
                          const TodosOverViewFilterApplied(
                              filter: TodosOverviewFilter.completedOnly));
                    },
                  )
                ];
              },
              icon: Icon(Icons.filter_alt),
            );
          }),
          PopupMenuButton(
              itemBuilder: (ctx) => [
                    PopupMenuItem(
                      child: Text("Mark all complete"),
                      onTap: () => ctx
                          .read<TodosOverviewBloc>()
                          .add(const TodosOverviewAllTodosToggled()),
                    ),
                    PopupMenuItem(
                      child: Text("Clear completed"),
                      onTap: () => ctx
                          .read<TodosOverviewBloc>()
                          .add(TodosOverviewAllCompletedTodosCleared()),
                    )
                  ])
        ],
      ),
      body: BlocBuilder<TodosOverviewBloc, TodosOverviewState>(
          builder: (context, state) {
        final filterdTodos = state.filter.applyAll(state.todos).toList();
        if (filterdTodos.length == 0) {
          return Center(
            child: Container(
              width: 300,
              height: 300,
              child: Image.asset('assets/images/no_todo.png'),
            ),
          );
        }
        return ListView.builder(
          itemBuilder: (_, index) => TodoListTile(
            todo: filterdTodos[index],
            onDismiss: (_) {
              context
                  .read<TodosOverviewBloc>()
                  .add(TodosOverviewTodoDeleted(todo: filterdTodos[index]));

              final snackBar = SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("You have deleted todo task"),
                    TextButton(
                        onPressed: () {
                          context
                              .read<TodosOverviewBloc>()
                              .add(TodosOverviewTodoUndo());
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                        child: const Text("UNDO"))
                  ],
                ),
              );

              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          itemCount: filterdTodos.length,
        );
      }),
    );
  }
}
