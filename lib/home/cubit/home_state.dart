part of 'home_cubit.dart';

enum HomeTab { todos, stats }

class HomeState extends Equatable {
  const HomeState(this.homeTab);

  final HomeTab homeTab;

  @override
  List<Object?> get props => [homeTab];
}
