part of 'init_config.dart';

mixin LoggerConfig {
  /// Run log zone
  static R runLogging<R extends Object?>(R Function() body) => l.capture<R>(
        body,
        _logOptions,
      );

  /// Log options
  static const _logOptions = LogOptions(
    printColors: false,
    messageFormatting: _formatLoggerMessage,
  );

  /// Time format
  static String _timeFormat(int input) => input.toString().padLeft(2, '0');

  /// Format message
  static Object _formatLoggerMessage(
    Object message,
    LogLevel logLevel,
    DateTime now,
  ) =>
      '${logLevel.emoji} ${now.formatted} | $message';

  /// Format error
  static String _formatError(
    String type,
    String error,
    StackTrace? stackTrace,
  ) {
    final trace = stackTrace ?? StackTrace.current;
    final buffer = StringBuffer('[$type]')
      ..write(' error: ')
      ..writeln(error)
      ..writeln('Stack trace:')
      ..write(Trace.from(trace).terse);
    return buffer.toString();
  }

  /// Log top level zone error
  static void logZoneError(Object? e, StackTrace s) {
    l.e(_formatError('Logger-Top-Level', e.toString(), s), s);
  }

  /// Log flutter error
  static void logFlutterError(FlutterErrorDetails details) {
    final s = details.stack;
    l.w(_formatError('Logger-Flutter', details.exceptionAsString(), s), s);
  }
}

extension on DateTime {
  String get formatted => [hour, minute, second].map(LoggerConfig._timeFormat).join(':');
}

extension on LogLevel {
  String get emoji => maybeWhen(
        shout: () => '❗️',
        error: () => '🚫',
        warning: () => '⚠️',
        info: () => '💡',
        debug: () => '🐞',
        orElse: () => '',
      );
}
