part of 'todos_overview_bloc.dart';

enum TodosOverviewStatus { initial, loading, failure, success }

class TodosOverviewState extends Equatable {
  const TodosOverviewState({
    this.status = TodosOverviewStatus.initial,
    this.todos = const [],
    this.filter = TodosOverviewFilter.all,
    this.lastDeletedTodo,
  });

  final TodosOverviewStatus status;
  final List<Todo> todos;
  final TodosOverviewFilter filter;
  final Todo? lastDeletedTodo;

  TodosOverviewState copyWith(
      {TodosOverviewStatus? status,
      List<Todo>? todos,
      TodosOverviewFilter? filter,
      Todo Function()? lastDeletedTodo}) {
    return TodosOverviewState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      filter: filter ?? this.filter,
      lastDeletedTodo:
          lastDeletedTodo == null ? this.lastDeletedTodo : lastDeletedTodo(),
    );
  }

  @override
  List<Object?> get props => [status, todos, filter, lastDeletedTodo];
}
