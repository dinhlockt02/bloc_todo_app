import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todos_repository/todos_repository.dart';

import '../models/todos_overview_filter.dart';

part 'todos_overview_event.dart';
part 'todos_overview_state.dart';

class TodosOverviewBloc extends Bloc<TodosOverviewEvent, TodosOverviewState> {
  TodosOverviewBloc(TodosRepository todosRepository)
      : _todosRepository = todosRepository,
        super(TodosOverviewState()) {
    on<TodosOverviewSubcriptionRequested>(_onTodosOverviewSubcriptionRequested);
    on<TodosOverviewTodoDeleted>(_onTodosOverviewTodoDeleted);
    on<TodosOverviewTodoCompleteToggled>(_onTodosOverviewTodoCompleteToggled);
    on<TodosOverViewFilterApplied>(_onTodosOverViewFilterApplied);
    on<TodosOverviewTodoUndo>(_onTodosOverviewTodoUndo);
    on<TodosOverviewAllTodosToggled>(_onTodosOverviewAllTodosToggled);
    on<TodosOverviewAllCompletedTodosCleared>(
        _onTodosOverviewAllCompletedTodosCleared);

    add(TodosOverviewSubcriptionRequested());
  }

  final TodosRepository _todosRepository;

  Future<void> _onTodosOverviewSubcriptionRequested(
      TodosOverviewSubcriptionRequested event,
      Emitter<TodosOverviewState> emit) async {
    emit(state.copyWith(status: TodosOverviewStatus.loading));

    await emit.forEach(_todosRepository.getTodos(),
        onData: (List<Todo> todos) => state.copyWith(todos: todos),
        onError: (_, __) => state.copyWith(
              status: TodosOverviewStatus.failure,
            ));
  }

  Future<void> _onTodosOverviewTodoDeleted(
    TodosOverviewTodoDeleted event,
    Emitter<TodosOverviewState> emit,
  ) async {
    emit(state.copyWith(lastDeletedTodo: () => event.todo));
    await _todosRepository.deleteTodo(event.todo.id);
  }

  Future<void> _onTodosOverviewTodoCompleteToggled(
      TodosOverviewTodoCompleteToggled event,
      Emitter<TodosOverviewState> emitter) async {
    await _todosRepository.saveTodo(event.todo.copyWith(
      isCompleted: event.isCompleted,
    ));
  }

  Future<void> _onTodosOverViewFilterApplied(TodosOverViewFilterApplied event,
      Emitter<TodosOverviewState> emitter) async {
    emit(state.copyWith(filter: event.filter));
  }

  Future<void> _onTodosOverviewTodoUndo(
      TodosOverviewTodoUndo event, Emitter<TodosOverviewState> emit) async {
    if (state.lastDeletedTodo != null) {
      await _todosRepository.saveTodo(state.lastDeletedTodo!);
    }
    emit(state.copyWith(lastDeletedTodo: null));
  }

  Future<void> _onTodosOverviewAllTodosToggled(
      TodosOverviewAllTodosToggled event,
      Emitter<TodosOverviewState> emit) async {
    await _todosRepository.completeAll(isCompleted: event.isCompleted);
  }

  Future<void> _onTodosOverviewAllCompletedTodosCleared(
    TodosOverviewAllCompletedTodosCleared event,
    Emitter<TodosOverviewState> emit,
  ) async {
    await _todosRepository.clearCompleted();
  }
}
