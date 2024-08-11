part of 'app_theme.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final CommonColors commonColors;
  final CommonTextStyles commonTextStyles;

  const AppThemeExtension({
    required this.commonColors,
    required this.commonTextStyles,
  });

  factory AppThemeExtension.lightThemeExtension() => AppThemeExtension(
        commonColors: _commonColors,
        commonTextStyles: _commonTextStyles,
      );

  factory AppThemeExtension.darkThemeExtension() => AppThemeExtension(
        commonColors: _commonColors,
        commonTextStyles: _commonTextStyles,
      );

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    CommonColors? commonColors,
    CommonTextStyles? commonTextStyles,
  }) =>
      AppThemeExtension(
        commonColors: commonColors ?? this.commonColors,
        commonTextStyles: commonTextStyles ?? this.commonTextStyles,
      );

  @override
  ThemeExtension<AppThemeExtension> lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) =>
      AppThemeExtension(
        commonColors: commonColors,
        commonTextStyles: commonTextStyles,
      );
}
