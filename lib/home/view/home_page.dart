import 'package:bloc_todo_app/edit_todo/views/edit_todo_page.dart';
import 'package:bloc_todo_app/home/cubit/home_cubit.dart';
import 'package:bloc_todo_app/todos_overview/views/todos_overview.dart';
import 'package:bloc_todo_app/todos_statistic/todos_statistic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTab =
        context.select((HomeCubit homeCubit) => homeCubit.state.homeTab);

    return Scaffold(
        body: IndexedStack(
            index: selectedTab.index,
            children: const [TodosOverviewPage(), TodosStatistic()]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(EditTodoPage.route());
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _HomeTabButton(
                icon: Icons.list_rounded,
                groupValue: selectedTab,
                value: HomeTab.todos,
              ),
              _HomeTabButton(
                icon: Icons.show_chart_rounded,
                groupValue: selectedTab,
                value: HomeTab.stats,
              )
            ],
          ),
        ));
  }
}

class _HomeTabButton extends StatelessWidget {
  _HomeTabButton(
      {Key? key,
      required IconData this.icon,
      required this.groupValue,
      required this.value})
      : super(key: key);

  IconData icon;
  HomeTab groupValue;
  HomeTab value;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: groupValue == value
            ? Theme.of(context).colorScheme.secondary
            : null,
      ),
      onPressed: () {
        context.read<HomeCubit>().setTab(value);
      },
    );
  }
}
