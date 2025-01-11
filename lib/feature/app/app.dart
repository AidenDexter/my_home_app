import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nested/nested.dart';

import '../../core/l10n/app_localizations.g.dart';
import '../../core/router/app_router.dart';
import '../../core/services/service_locator/service_locator.dart';
import '../../core/theme/app_theme.dart';
import '../choose_area/presentation/choose_area_scope.dart';
import '../currency_control/presentation/currency_scope.dart';
import '../favourites/presentation/favourites_scope.dart';
import '../localization_control/presentation/localization_scope.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Nested(
      children: const [
        ChooseAreaScope(),
        CurrencyScope(),
        LocalizationScope(),
        FavouritesScope(),
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
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();

    initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();

    super.dispose();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Handle links
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      debugPrint('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    _router.push(uri.fragment);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: LocalizationScope.localeOf(context),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
      theme: AppTheme.lightThemeData,
      builder: (context, child) => _MediaQuery(
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}

@immutable
class _MediaQuery extends StatelessWidget {
  final Widget child;
  const _MediaQuery({required this.child});

  @override
  Widget build(BuildContext context) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
        child: child,
      );
}
