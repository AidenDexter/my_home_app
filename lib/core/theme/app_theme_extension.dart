part of 'app_theme.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final CommonColors commonColors;

  const AppThemeExtension({
    required this.commonColors,
  });

  factory AppThemeExtension.lightThemeExtension() => const AppThemeExtension(
        commonColors: _commonColors,
      );

  factory AppThemeExtension.darkThemeExtension() => const AppThemeExtension(
        commonColors: _commonColors,
      );

  @override
  // ignore: long-parameter-list
  ThemeExtension<AppThemeExtension> copyWith({
    CommonColors? commonColors,
  }) =>
      AppThemeExtension(
        commonColors: commonColors ?? this.commonColors,
      );

  @override
  ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) =>
      AppThemeExtension(
        commonColors: commonColors,
      );
}
