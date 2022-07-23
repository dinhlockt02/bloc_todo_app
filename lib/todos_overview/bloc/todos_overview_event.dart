part of 'todos_overview_bloc.dart';

abstract class TodosOverviewEvent extends Equatable {
  const TodosOverviewEvent();
}

class TodosOverviewSubcriptionRequested extends TodosOverviewEvent {
  @override
  List<Object?> get props => [];
}

class TodosOverviewTodoDeleted extends TodosOverviewEvent {
  const TodosOverviewTodoDeleted({required this.todo});

  final Todo todo;

  @override
  List<Object?> get props => [todo];
}

class TodosOverviewTodoUndo extends TodosOverviewEvent {
  @override
  List<Object?> get props => [];
}

class TodosOverviewTodoCompleteToggled extends TodosOverviewEvent {
  const TodosOverviewTodoCompleteToggled({
    required this.todo,
    required this.isCompleted,
  });

  final Todo todo;
  final bool isCompleted;

  @override
  List<Object?> get props => [todo, isCompleted];
}

class TodosOverViewFilterApplied extends TodosOverviewEvent {
  const TodosOverViewFilterApplied({required this.filter});

  final TodosOverviewFilter filter;

  @override
  List<Object?> get props => [filter];
}

class TodosOverviewAllTodosToggled extends TodosOverviewEvent {
  const TodosOverviewAllTodosToggled({this.isCompleted = true});

  final bool isCompleted;

  @override
  List<Object> get props => [isCompleted];
}

class TodosOverviewAllCompletedTodosCleared extends TodosOverviewEvent {
  @override
  List<Object?> get props => [];
}
