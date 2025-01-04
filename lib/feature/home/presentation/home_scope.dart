import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/service_locator/service_locator.dart';
import '../../localization_control/bloc/localization_control_bloc.dart';
import '../../localization_control/presentation/localization_scope.dart';
import '../bloc/home_super_vip.dart';
import '../bloc/home_vip_plus.dart';

@immutable
class HomeScope extends StatelessWidget {
  final Widget child;

  const HomeScope({required this.child, super.key});

  static void readOf(BuildContext context) {
    final locale = LocalizationScope.getLocaleCode(context, listen: false);
    context.read<HomeSuperVipBloc>().add(HomeSuperVipEvent.read(locale: locale));
    context.read<HomeVipPlusBloc>().add(HomeVipPlusEvent.read(locale: locale));
  }

  static void readSuperVipOf(BuildContext context) {
    final locale = LocalizationScope.getLocaleCode(context, listen: false);
    context.read<HomeSuperVipBloc>().add(HomeSuperVipEvent.read(locale: locale));
  }

  static void readVipPlusOf(BuildContext context) {
    final locale = LocalizationScope.getLocaleCode(context, listen: false);
    context.read<HomeVipPlusBloc>().add(HomeVipPlusEvent.read(locale: locale));
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<HomeSuperVipBloc>(
            create: (context) => getIt<HomeSuperVipBloc>()
              ..add(HomeSuperVipEvent.read(locale: LocalizationScope.getLocaleCode(context, listen: false))),
          ),
          BlocProvider<HomeVipPlusBloc>(
            create: (context) => getIt<HomeVipPlusBloc>()
              ..add(HomeVipPlusEvent.read(locale: LocalizationScope.getLocaleCode(context, listen: false))),
          ),
        ],
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
