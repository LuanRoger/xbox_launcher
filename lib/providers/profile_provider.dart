import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/profile_model.dart';
import 'package:xbox_launcher/providers/background_profile_preferences.dart';
import 'package:xbox_launcher/providers/theme_data_profile.dart';
import 'package:xbox_launcher/shared/app_data_files.dart';
import 'package:xbox_launcher/utils/io_utils.dart';

class ProfileProvider extends ChangeNotifier {
  late ProfileModel _currentProfile;

  int get preferedColorIndex =>
      _currentProfile.themePreferences.preferedColorIndex;
  set preferedColorIndex(int preferedColorIndex) {
    _currentProfile.themePreferences.preferedColorIndex = preferedColorIndex;
    notifyListeners();
  }

  int get backgroundColorIndex =>
      _currentProfile.backgroundPreferences.backgroundColorIndex;
  set backgroundColorIndex(int backgroundColorIndex) {
    _currentProfile.backgroundPreferences.backgroundColorIndex =
        backgroundColorIndex;
    notifyListeners();
  }

  String? get imageBackgroundPath =>
      _currentProfile.backgroundPreferences.imageBackgroundPath;
  set imageBackgroundPath(String? imageBackgroundPath) {
    _currentProfile.backgroundPreferences.imageBackgroundPath =
        imageBackgroundPath;
    notifyListeners();
  }

  bool get preferenceByImage =>
      _currentProfile.backgroundPreferences.preferenceByImage;
  set preferenceByImage(bool preferenceByImage) {
    _currentProfile.backgroundPreferences.preferenceByImage = preferenceByImage;
    notifyListeners();
  }

  Brightness get brightness => _currentProfile.themePreferences.brightness;
  Color get accentColor => _currentProfile.themePreferences.accentColor;
  String get fontFamily => _currentProfile.themePreferences.fontFamily;
  FocusThemeData get focusThemeData =>
      _currentProfile.themePreferences.focusThemeData;
  Color get solidColorBackground =>
      _currentProfile.backgroundPreferences.solidColorBackground;

  void resetBackground() => _currentProfile.backgroundPreferences.reset();

  Future saveProfile() async {
    String jsonProfileText = json.encode(_currentProfile.toJson());
    await IOUtils.writeFile(
        jsonProfileText, AppDataFiles.PROFILES_JSON_FILE_PATH);
  }

  Future loadProfile() async {
    String? jsonProfileText =
        await IOUtils.readFile(AppDataFiles.PROFILES_JSON_FILE_PATH);
    if (jsonProfileText == null) {
      _createDefault();
      saveProfile();

      return;
    }

    _currentProfile = json.decode(jsonProfileText);
  }

  void _createDefault() {
    ProfileModel defaultProfile = ProfileModel();
    defaultProfile.name = "Default";
    defaultProfile.preferedServer = "en_US";

    defaultProfile.backgroundPreferences =
        BackgroundProfilePreferences(0, null);
    defaultProfile.themePreferences = ThemeProfilePreferences(0);

    _currentProfile = defaultProfile;
  }
}
