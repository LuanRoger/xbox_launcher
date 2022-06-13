import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_colors.dart';

class ThemeProfilePreferences {
  int preferedColorIndex;

  ThemeProfilePreferences(this.preferedColorIndex);
  factory ThemeProfilePreferences.fromJson(Map<String, dynamic> json) =>
      ThemeProfilePreferences(json["preferedColorIndex"]);
  Map<String, dynamic> toJson() => {"preferedColorIndex": preferedColorIndex};

  final Brightness brightness = Brightness.dark;
  final String fontFamily = "Bahnschrift";
  Color get accentColor {
    return AppColors.COLORS_LIST[preferedColorIndex];
  }

  FocusThemeData get focusThemeData {
    return FocusThemeData(
        glowFactor: 0.5,
        glowColor: accentColor.withOpacity(0.03),
        primaryBorder: BorderSide(
          width: 2.0,
          color: accentColor,
        ));
  }
}
