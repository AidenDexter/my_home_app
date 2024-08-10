import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:flutter/foundation.dart' show FlutterError, FlutterErrorDetails;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart';

import 'package:stack_trace/stack_trace.dart';

import '../../core/observer/app_bloc_observer.dart';

part 'logger_config.dart';

mixin InitConfig {
  /// Run init config
  static R run<R extends Object?>(R Function() body) => _runZonedLogger<R>(
        () => _runZonedGuarded<R>(
          () => _runBlocZoned<R>(body),
        ),
      );

  /// Run zoned logger
  static R _runZonedLogger<R extends Object?>(R Function() body) => LoggerConfig.runLogging<R>(body);

  /// Run zoned guarded
  static R _runZonedGuarded<R extends Object?>(R Function() body) {
    final run = runZonedGuarded<R>(
      () {
        final sourceFlutterError = FlutterError.onError;
        FlutterError.onError = (details) {
          LoggerConfig.logFlutterError(details);
          sourceFlutterError?.call(details);
        };
        return body();
      },
      // Зона перехвата всех ошибок верхнего уровня
      LoggerConfig.logZoneError,
    );
    if (run == null) {
      l.w('Не удалось запустить приложение в безопасной зоне');
      return body();
    }
    return run;
  }

  /// Run bloc zone, and setup bloc observer, event transformer
  static R _runBlocZoned<R extends Object?>(R Function() body) {
    Bloc.observer = AppBlocObserver.instance();
    Bloc.transformer = bloc_concurrency.sequential<Object?>();
    return body();
  }
}
