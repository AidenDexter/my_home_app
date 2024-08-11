part of 'app_theme.dart';

class ButtonStyles {
  final elevatedButtonThemeData = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: _commonColors.green100,
      foregroundColor: _commonColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      minimumSize: const Size.fromHeight(48),
      maximumSize: const Size.fromHeight(48),
      textStyle: _commonTextStyles.label,
      elevation: 0,
    ),
  );
  final textButtonThemeData = TextButtonThemeData();

  final radioButtonTheme = RadioThemeData();
}
