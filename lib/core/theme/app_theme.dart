// ignore_for_file: avoid_field_initializers_in_const_classes
import 'package:flutter/material.dart';

part 'common_colors.dart';
part 'app_theme_extension.dart';

const _commonColors = CommonColors();

// ignore: avoid_classes_with_only_static_members
abstract class AppTheme {
  static ThemeData get lightThemeData => _lightThemeData;
  static ThemeData get darkThemeData => _darkThemeData;

  // ignore: library_private_types_in_public_api
  static AppThemeExtension themeExtension(BuildContext context) => Theme.of(context).extension<AppThemeExtension>()!;
}

final _lightThemeData = ThemeData(
  useMaterial3: true,
  extensions: [
    AppThemeExtension.lightThemeExtension(),
  ],
  cardColor: _commonColors.white,
  scaffoldBackgroundColor: _commonColors.neutralgrey3,
);

final _darkThemeData = ThemeData(
  useMaterial3: true,
  extensions: [
    AppThemeExtension.darkThemeExtension(),
  ],
  cardColor: _commonColors.black,
  scaffoldBackgroundColor: _commonColors.black,
);
