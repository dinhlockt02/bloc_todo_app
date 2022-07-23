import 'package:todos_repository/todos_repository.dart';

enum TodosOverviewFilter { all, active, completedOnly }

extension TodosOverviewFilterX on TodosOverviewFilter {
  bool apply(Todo todo) {
    switch (this) {
      case TodosOverviewFilter.all:
        return true;
      case TodosOverviewFilter.active:
        return todo.isCompleted == false;
      case TodosOverviewFilter.completedOnly:
        return todo.isCompleted == true;
      default:
        return false;
    }
  }

  Iterable<Todo> applyAll(Iterable<Todo> todos) {
    return todos.where(apply);
  }
}
