// ignore_for_file: avoid_field_initializers_in_const_classes
import 'package:flutter/material.dart';

part 'common_colors.dart';
part 'animation_durations.dart';
part 'app_theme_extension.dart';
part 'typography.dart';
part 'common_text_styles.dart';
part 'button_styles.dart';
part 'app_bar_theme.dart';

const _commonColors = CommonColors();
const _typography = _Typography();
final _commonTextStyles = CommonTextStyles();
final _buttonStyles = _ButtonStyles();
final _appBarThemes = _AppBarThemes();
const _durations = AnimationDurations();

// ignore: avoid_classes_with_only_static_members
abstract class AppTheme {
  static ThemeData get lightThemeData => _lightThemeData;
  static ThemeData get darkThemeData => _darkThemeData;

  // ignore: library_private_types_in_public_api
  static AppThemeExtension themeExtension(BuildContext context) => Theme.of(context).extension<AppThemeExtension>()!;
}

final _lightThemeData = ThemeData(
  appBarTheme: _appBarThemes.light,
  useMaterial3: true,
  primaryColor: _commonColors.green100,
  extensions: [
    AppThemeExtension.lightThemeExtension(),
  ],
  cardColor: _commonColors.white,
  elevatedButtonTheme: _buttonStyles.elevatedButtonThemeData,
  radioTheme: _buttonStyles.radioButtonTheme,
  textButtonTheme: _buttonStyles.textButtonThemeData,
  scaffoldBackgroundColor: _commonColors.neutralgrey3,
  floatingActionButtonTheme: _buttonStyles.floatingActionButtonTheme,
);

final _darkThemeData = ThemeData(
  useMaterial3: true,
  primaryColor: _commonColors.green100,
  extensions: [
    AppThemeExtension.darkThemeExtension(),
  ],
  cardColor: _commonColors.black,
  elevatedButtonTheme: _buttonStyles.elevatedButtonThemeData,
  radioTheme: _buttonStyles.radioButtonTheme,
  scaffoldBackgroundColor: _commonColors.black,
);
