part of 'app_theme.dart';

class _ButtonStyles {
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
  final textButtonThemeData = TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: _commonTextStyles.body,
      foregroundColor: _commonColors.green100,
    ),
  );

  final radioButtonTheme = RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.selected)) {
        return _commonColors.green100;
      }
      return _commonColors.green10;
    }),
  );
}
