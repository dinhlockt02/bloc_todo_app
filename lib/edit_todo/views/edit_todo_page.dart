import 'package:bloc_todo_app/edit_todo/bloc/edit_todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_api/todos_api.dart';
import 'package:todos_repository/todos_repository.dart';

class EditTodoPage extends StatelessWidget {
  const EditTodoPage({Key? key}) : super(key: key);

  static Route route({Todo? initialTodo}) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (ctx) => EditTodoBloc(
          todosRepository: ctx.read<TodosRepository>(),
          initialTodo: initialTodo,
        ),
        child: const EditTodoPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditTodoBloc, EditTodoState>(
      listener: (context, state) {
        if (state.isEditingComplete) {
          Navigator.of(context).pop();
        }
      },
      child: const EditTodoView(),
    );
  }
}

class EditTodoView extends StatelessWidget {
  const EditTodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.read<EditTodoBloc>().state.isEditTodo ? "Edit" : "Add",
        ),
      ),
      body: const EditTodoForm(),
    );
  }
}

class EditTodoForm extends StatelessWidget {
  const EditTodoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _TitleTextFormField(),
          _DescriptionTextFormField(),
          _SavedTodoButton()
        ],
      ),
    );
  }
}

class _TitleTextFormField extends StatelessWidget {
  const _TitleTextFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initialTitle =
        context.read<EditTodoBloc>().state.initialTodo?.title ?? '';
    return Container(
        margin: EdgeInsets.only(top: 24),
        child: TextFormField(
          key: Key("title_text_form_Field"),
          decoration: const InputDecoration(
            label: Text("Title"),
            border: OutlineInputBorder(),
          ),
          initialValue: initialTitle,
          onChanged: (value) =>
              context.read<EditTodoBloc>().add(EditTodoTitleChanged(value)),
        ));
  }
}

class _DescriptionTextFormField extends StatelessWidget {
  const _DescriptionTextFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final initialDescription =
        context.read<EditTodoBloc>().state.initialTodo?.description ?? '';
    return Container(
        margin: EdgeInsets.only(top: 24),
        child: TextFormField(
          key: Key("description_text_form_field"),
          decoration: const InputDecoration(
            label: Text("Description"),
            border: OutlineInputBorder(),
            alignLabelWithHint: true,
          ),
          maxLines: 3,
          initialValue: initialDescription,
          onChanged: (value) => context
              .read<EditTodoBloc>()
              .add(EditTodoDescriptionChanged(value)),
        ));
  }
}

class _SavedTodoButton extends StatelessWidget {
  const _SavedTodoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.read<EditTodoBloc>().add(EditTodoSaved());
        },
        child: const Text("SAVE"),
      ),
    );
  }
}
