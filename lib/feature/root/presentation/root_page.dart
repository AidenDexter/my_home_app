import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bottom_navigation_bloc.dart';
import 'bottom_navigation_scope.dart';
import 'components/navigation_bar.dart';

class RootPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const RootPage({
    required this.navigationShell,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationScope(
      child: BlocConsumer<BottomNavigationBloc, BottomNavigationState>(
        listener: _bottomNavListener,
        builder: (context, state) {
          return Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            bottomNavigationBar: BottomNavBar(currentIndex: state.currentPageIndex),
            body: navigationShell,
          );
        },
      ),
    );
  }

  void _bottomNavListener(_, BottomNavigationState state) {
    final index = state.currentPageIndex;
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
