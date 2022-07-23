import 'package:bloc_todo_app/edit_todo/views/edit_todo_page.dart';
import 'package:bloc_todo_app/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repository/todos_repository.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile({Key? key, required this.todo, required this.onDismiss})
      : super(key: key);

  final Todo todo;
  final DismissDirectionCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.endToStart,
      onDismissed: onDismiss,
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (value) {
            context
                .read<TodosOverviewBloc>()
                .add(TodosOverviewTodoCompleteToggled(
                  todo: todo,
                  isCompleted: value ?? false,
                ));
          },
        ),
        title: Text(todo.title),
        subtitle: todo.description.isEmpty
            ? null
            : Text(
                todo.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
        onTap: () {
          Navigator.of(context).push(EditTodoPage.route(initialTodo: todo));
        },
      ),
    );
  }
}
