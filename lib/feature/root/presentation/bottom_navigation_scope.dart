import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/service_locator/service_locator.dart';
import '../bloc/bottom_navigation_bloc.dart';

@immutable
class BottomNavigationScope extends StatelessWidget {
  final Widget child;

  const BottomNavigationScope({required this.child, super.key});

  static void change(BuildContext context, int pageIndex) =>
      context.read<BottomNavigationBloc>().add(BottomNavigationEvent.changed(pageIndex));

  @override
  Widget build(BuildContext context) => BlocProvider<BottomNavigationBloc>(
        create: (context) => getIt<BottomNavigationBloc>(),
        child: child,
      );
}
