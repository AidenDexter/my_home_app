import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extension/extensions.dart';
import '../../bloc/bottom_navigation_bloc.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({
    required this.currentIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return SizedBox(
      height: 64 + bottomPadding,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) => BlocProvider.of<BottomNavigationBloc>(context).add(
          BottomNavigationEvent.pageChanged(index),
        ),
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
          ),
        ],
      ),
    );
  }

  Color getColor(BuildContext context, {required bool isActive}) =>
      isActive ? context.theme.commonColors.green100 : context.theme.commonColors.darkGrey30;
}
