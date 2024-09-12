import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/service_locator/service_locator.dart';
import '../../localization_control/bloc/localization_control_bloc.dart';
import '../../localization_control/presentation/localization_scope.dart';
import '../bloc/home_bloc.dart';

@immutable
class HomeScope extends StatelessWidget {
  final Widget child;

  const HomeScope({required this.child, super.key});

  static void readOf(BuildContext context) {
    final locale = LocalizationScope.getLocaleCode(context, listen: false);
    context.read<HomeBloc>().add(HomeEvent.read(locale: locale));
  }

  @override
  Widget build(BuildContext context) => BlocProvider<HomeBloc>(
        create: (context) =>
            getIt<HomeBloc>()..add(HomeEvent.read(locale: LocalizationScope.getLocaleCode(context, listen: false))),
        child: _LocaleListener(child: child),
      );
}

class _LocaleListener extends StatelessWidget {
  final Widget child;
  const _LocaleListener({required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocalizationControlBloc, LocalizationControlState>(
      listener: (context, state) => HomeScope.readOf(context),
      child: child,
    );
  }
}
