import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xbox_launcher/shared/app_colors.dart';

class ThemeDataProvider extends ChangeNotifier {
  late SharedPreferences themeSharedPreferenceInstance;
  late int _preferedColorIndex;
  int get preferedColorIndex {
    return _preferedColorIndex;
  }

  set preferedColorIndex(int colorIndex) {
    _preferedColorIndex = colorIndex;
    themeSharedPreferenceInstance.setInt("preferedColor", colorIndex);

    notifyListeners();
  }

  final Brightness brightness = Brightness.dark;
  final String fontFamily = "Bahnschrift";
  Color get accentColor {
    return AppColors.COLORS_LIST[_preferedColorIndex];
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

  Future init() async {
    themeSharedPreferenceInstance = await SharedPreferences.getInstance();

    preferedColorIndex =
        themeSharedPreferenceInstance.getInt("preferedColor") ?? 0;
  }
}
