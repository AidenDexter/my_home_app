import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../core/environment/app_environment.dart';
import '../core/services/service_locator/service_locator.dart';
import '../feature/app/app.dart';
import 'init_config/init_config.dart';

/// App launch.
Future<void> run() => InitConfig.run<Future<void>>(
      () async {
        final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
        // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
        );
        await initFirebaseServices();
        await _initDependencies();
        runApp(const App());
      },
    );

Future<void> initFirebaseServices() async {
  // await Firebase.initializeApp(options: getFirebaseOptions());
  // FlutterError.onError = (errorDetails) {
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  // };
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };
}

Future<void> _initDependencies() async {
  await configureDependencies();
  await _initDotEnv();
}

Future<void> _initDotEnv() async {
  await dotenv.load();
  final config = AppEnvironment<AppConfig>.instance().config;
  AppEnvironment.instance().config = config.copyWith(url: dotenv.env['API_HOST']);
}