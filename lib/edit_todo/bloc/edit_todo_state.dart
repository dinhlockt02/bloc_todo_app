part of 'edit_todo_bloc.dart';

enum EditTodoStatus { initial, loading, success, failure }

class EditTodoState extends Equatable {
  const EditTodoState({
    this.initialTodo,
    this.editTodoStatus = EditTodoStatus.initial,
    this.title = '',
    this.description = ',',
  });

  final Todo? initialTodo;
  final EditTodoStatus editTodoStatus;
  final String title;
  final String description;

  bool get isEditTodo => initialTodo != null;
  bool get isEditingComplete =>
      [EditTodoStatus.success, EditTodoStatus.failure].contains(editTodoStatus);

  EditTodoState copyWith(
          {EditTodoStatus? editTodoStatus,
          String? title,
          String? description}) =>
      EditTodoState(
        initialTodo: initialTodo,
        editTodoStatus: editTodoStatus ?? this.editTodoStatus,
        title: title ?? this.title,
        description: description ?? this.description,
      );

  @override
  List<Object?> get props => [initialTodo, editTodoStatus, title, description];
}
