import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashUtil {
  static SplashUtil? _instance;

  static bool _splashEnabled = true;

  const SplashUtil._();

  factory SplashUtil() {
    return _instance ??= const SplashUtil._();
  }

  static void removeSplash() {
    if (!_splashEnabled) return;
    FlutterNativeSplash.remove();
    _splashEnabled = false;
  }
}
