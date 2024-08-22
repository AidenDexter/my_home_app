import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nested/nested.dart';

import '../../core/l10n/app_localizations.g.dart';
import '../../core/router/app_router.dart';
import '../../core/services/service_locator/service_locator.dart';
import '../../core/theme/app_theme.dart';
import '../choose_area/presentation/choose_area_scope.dart';
import '../localization_control/presentation/localization_scope.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Nested(
      children: const [
        ChooseAreaScope(),
        LocalizationScope(),
      ],
      child: const _MaterialApp(),
    );
  }
}

class _MaterialApp extends StatefulWidget {
  const _MaterialApp();

  @override
  State<_MaterialApp> createState() => _MaterialAppState();
}

class _MaterialAppState extends State<_MaterialApp> {
  final GoRouter _router = getIt<AppRouter>().router;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: LocalizationScope.localeOf(context),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
      theme: AppTheme.lightThemeData,
    );
  }
}
