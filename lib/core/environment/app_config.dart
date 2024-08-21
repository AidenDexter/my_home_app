part of 'app_environment.dart';

/// Application configuration.
@immutable
class AppConfig {
  /// Server url.
  final String url;
  final String urlHome;
  final String urlTnet;

  final Flavor flavor;

  /// Additional application settings in debug mode.
  final DebugOptions debugOptions;

  /// Create an instance [AppConfig].
  const AppConfig({
    required this.debugOptions,
    required this.flavor,
    this.url = '',
    this.urlHome = '',
    this.urlTnet = '',
  });

  /// Create an instance [AppConfig] with modified parameters.
  AppConfig copyWith({
    String? url,
    String? urlHome,
    String? urlTnet,
    Flavor? flavor,
    DebugOptions? debugOptions,
  }) =>
      AppConfig(
        url: url ?? this.url,
        urlHome: urlHome ?? this.urlHome,
        urlTnet: urlTnet ?? this.urlTnet,
        flavor: flavor ?? this.flavor,
        debugOptions: debugOptions ?? this.debugOptions,
      );
}

enum Flavor { dev, prod }
