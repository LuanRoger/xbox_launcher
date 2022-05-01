import 'package:fluent_ui/fluent_ui.dart';

class AppThemeData {
  static ThemeData defaultTheme = ThemeData(
      brightness: Brightness.dark,
      fontFamily: "Bahnschrift",
      focusTheme: FocusThemeData(
          glowFactor: 0.1,
          glowColor: Colors.green.withOpacity(0.1),
          primaryBorder: BorderSide(
            width: 2.0,
            color: Colors.green,
          )));
}
