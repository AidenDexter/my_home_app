import 'package:flutter/foundation.dart' show ValueNotifier, immutable;

part 'debug_options.dart';
part 'app_config.dart';

/// AppEnvironment configuration.
class AppEnvironment<T> {
  /// Instance
  static AppEnvironment<dynamic>? _instance;
  final ValueNotifier<T> _config;

  /// Configuration.
  T get config => _config.value;
  set config(T c) => _config.value = c;

  AppEnvironment._(T config) : _config = ValueNotifier(config);

  /// Provides instance [AppEnvironment].
  factory AppEnvironment.instance() => _instance! as AppEnvironment<T>;

  /// Initializing the AppEnvironment.
  static void init<T>({required T config}) {
    _instance ??= AppEnvironment<T>._(config);
  }
}
