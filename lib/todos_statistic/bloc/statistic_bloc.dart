import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todos_repository/todos_repository.dart';

part 'statistic_event.dart';
part 'statistic_state.dart';

class StatisticBloc extends Bloc<StatisticEvent, StatisticState> {
  final TodosRepository _todosRepository;

  StatisticBloc(TodosRepository todosRepository)
      : _todosRepository = todosRepository,
        super(StatisticState()) {
    on<StatisticStateInitialized>(_onStatisticStateInitialized);

    add(StatisticStateInitialized());
  }

  Future<void> _onStatisticStateInitialized(
      StatisticStateInitialized event, Emitter<StatisticState> emit) async {
    emit(state.copyWith(status: StatStatus.loading));
    await emit.forEach(_todosRepository.getTodos(),
        onData: (List<Todo> todos) {
          final activeCount = todos.where((todo) => !todo.isCompleted).length;
          final completeCount = todos.where((todo) => todo.isCompleted).length;
          return state.copyWith(
              status: StatStatus.success,
              activeCount: activeCount,
              completeCount: completeCount);
        },
        onError: (error, stackTrace) =>
            state.copyWith(status: StatStatus.failure));
  }
}
