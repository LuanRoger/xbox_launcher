import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesController {
  late SharedPreferences preferenceInstance;
  late int preferedColor;

  PreferencesController() {
    init();
  }

  void init() async {
    preferenceInstance = await SharedPreferences.getInstance();
    preferedColor = preferenceInstance.getInt("preferedColor") ?? 0;
  }
}
