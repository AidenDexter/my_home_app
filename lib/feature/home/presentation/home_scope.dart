import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/service_locator/service_locator.dart';
import '../bloc/home_bloc.dart';

@immutable
class HomeScope extends StatelessWidget {
  final Widget child;

  const HomeScope({required this.child, super.key});

  static void readOf(BuildContext context) => context.read<HomeBloc>().add(const HomeEvent.read());

  @override
  Widget build(BuildContext context) => BlocProvider<HomeBloc>(
        create: (context) => getIt<HomeBloc>()..add(const HomeEvent.read()),
        child: child,
      );
}
