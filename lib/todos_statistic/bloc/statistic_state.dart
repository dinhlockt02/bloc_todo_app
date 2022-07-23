part of 'statistic_bloc.dart';

enum StatStatus { initial, loading, success, failure }

class StatisticState extends Equatable {
  const StatisticState({
    this.status = StatStatus.initial,
    this.activeCount = 0,
    this.completeCount = 0,
  });

  final StatStatus status;
  final int activeCount;
  final int completeCount;

  @override
  List<Object> get props => [status, activeCount, completeCount];

  StatisticState copyWith(
      {StatStatus? status, int? activeCount, int? completeCount}) {
    return StatisticState(
      status: status ?? this.status,
      activeCount: activeCount ?? this.activeCount,
      completeCount: completeCount ?? this.completeCount,
    );
  }
}
