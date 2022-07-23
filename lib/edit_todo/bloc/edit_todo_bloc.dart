import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_repository/todos_repository.dart';

part 'edit_todo_event.dart';
part 'edit_todo_state.dart';

class EditTodoBloc extends Bloc<EditTodoEvent, EditTodoState> {
  EditTodoBloc({
    Todo? initialTodo,
    required TodosRepository todosRepository,
  })  : _todosRepository = todosRepository,
        super(EditTodoState(initialTodo: initialTodo)) {
    on<EditTodoInitialed>(_onEditTodoInitialed);
    on<EditTodoTitleChanged>(_onEditTodoTitleChanged);
    on<EditTodoDescriptionChanged>(_onEditTodoDescriptionChanged);
    on<EditTodoSaved>(_onEditTodoSaved);
    add(EditTodoInitialed());
  }

  final TodosRepository _todosRepository;

  void _onEditTodoInitialed(
      EditTodoInitialed event, Emitter<EditTodoState> emit) {
    if (state.initialTodo != null) {
      emit(state.copyWith(
          title: state.initialTodo!.title,
          description: state.initialTodo!.description));
    }
  }

  void _onEditTodoTitleChanged(
    EditTodoTitleChanged event,
    Emitter<EditTodoState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onEditTodoDescriptionChanged(
      EditTodoDescriptionChanged event, Emitter<EditTodoState> emit) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onEditTodoSaved(
      EditTodoSaved event, Emitter<EditTodoState> emit) async {
    emit(state.copyWith(editTodoStatus: EditTodoStatus.loading));
    try {
      late Todo todo;
      if (state.isEditTodo) {
        todo = state.initialTodo!
            .copyWith(title: state.title, description: state.description);
      } else {
        todo = Todo(title: state.title, description: state.description);
      }
      await _todosRepository.saveTodo(todo);
      emit(state.copyWith(editTodoStatus: EditTodoStatus.success));
    } catch (e) {
      emit(state.copyWith(editTodoStatus: EditTodoStatus.failure));
    }
  }
}
