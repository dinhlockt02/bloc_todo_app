import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState(HomeTab.todos));

  void setTab(HomeTab homeTab) => emit(HomeState(homeTab));
}
