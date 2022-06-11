// ignore_for_file: constant_identifier_names
import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xbox_launcher/controllers/apps_historic.dart';
import 'package:xbox_launcher/models/app_model.dart';
import 'package:xbox_launcher/models/profile_model.dart';
import 'package:xbox_launcher/providers/background_profile_preferences.dart';
import 'package:xbox_launcher/providers/theme_data_profile.dart';
import 'package:xbox_launcher/shared/app_consts.dart';
import 'package:xbox_launcher/shared/app_data_files.dart';
import 'package:xbox_launcher/utils/io_utils.dart';

class ProfileProvider extends ChangeNotifier {
  static const DEFAULT_USERNAME = "Default";

  late SharedPreferences profilePreferences;
  List<ProfileModel>? _profileBuffer;
  late ProfileModel _currentProfile;

  Future init() async {
    profilePreferences = await SharedPreferences.getInstance();
    await loadProfiles();
    _setCurrentByName(
        profilePreferences.getString("lastCurrentProfile") ?? DEFAULT_USERNAME);
  }

  List<ProfileModel>? get profilesList => _profileBuffer;

  String get name => _currentProfile.name;
  set name(String name) {
    _currentProfile.name = name;

    notifyListeners();
    saveCurrentProfile();
  }

  String get preferedServer => _currentProfile.preferedServer;
  set preferedServer(String preferedServer) {
    _currentProfile.preferedServer = preferedServer;

    saveCurrentProfile();
  }

  String? get xcloudGamesJsonPath => _currentProfile.xcloudGamesJsonPath;
  set xcloudGamesJsonPath(String? xcloudGamesJsonPath) {
    _currentProfile.xcloudGamesJsonPath = xcloudGamesJsonPath;

    saveCurrentProfile();
  }

  String? get profileImagePath => _currentProfile.profileImagePath;
  set profileImagePath(String? profileImagePath) {
    _currentProfile.profileImagePath = profileImagePath;

    notifyListeners();
    saveCurrentProfile();
  }

  List<AppModel> get lastApps => _currentProfile.appsHistoric.lastApps;
  void addApp(AppModel appModel) {
    _currentProfile.appsHistoric.addApp(appModel);

    notifyListeners();
    saveCurrentProfile();
  }

  int get preferedColorIndex =>
      _currentProfile.themePreferences.preferedColorIndex;
  set preferedColorIndex(int preferedColorIndex) {
    _currentProfile.themePreferences.preferedColorIndex = preferedColorIndex;

    notifyListeners();
    saveCurrentProfile();
  }

  int get backgroundColorIndex =>
      _currentProfile.backgroundPreferences.backgroundColorIndex;
  set backgroundColorIndex(int backgroundColorIndex) {
    _currentProfile.backgroundPreferences.backgroundColorIndex =
        backgroundColorIndex;

    notifyListeners();
    saveCurrentProfile();
  }

  String? get imageBackgroundPath =>
      _currentProfile.backgroundPreferences.imageBackgroundPath;
  set imageBackgroundPath(String? imageBackgroundPath) {
    _currentProfile.backgroundPreferences.imageBackgroundPath =
        imageBackgroundPath;

    notifyListeners();
    saveCurrentProfile();
  }

  bool get preferenceByImage =>
      _currentProfile.backgroundPreferences.preferenceByImage;
  set preferenceByImage(bool preferenceByImage) {
    _currentProfile.backgroundPreferences.preferenceByImage = preferenceByImage;

    notifyListeners();
    saveCurrentProfile();
  }

  Brightness get brightness => _currentProfile.themePreferences.brightness;
  Color get accentColor => _currentProfile.themePreferences.accentColor;
  String get fontFamily => _currentProfile.themePreferences.fontFamily;
  FocusThemeData get focusThemeData =>
      _currentProfile.themePreferences.focusThemeData;
  Color get solidColorBackground =>
      _currentProfile.backgroundPreferences.solidColorBackground;

  void resetBackground() => _currentProfile.backgroundPreferences.reset();

  void saveCurrentProfile() async {
    await loadProfiles();
    _profileBuffer!
        .removeWhere((element) => element.name == _currentProfile.name);
    _profileBuffer!.add(_currentProfile);

    await saveProfiles();
  }

  Future saveProfiles() async {
    JsonEncoder encoder = JsonEncoder.withIndent(' ' * 4);
    String jsonText = encoder
        .convert(_profileBuffer!.map((profile) => profile.toJson()).toList());

    await IOUtils.writeFile(jsonText, AppDataFiles.PROFILES_JSON_FILE_PATH);
  }

  Future loadProfiles({String? name}) async {
    String? profilesText =
        await IOUtils.readFile(AppDataFiles.PROFILES_JSON_FILE_PATH);
    if (profilesText == null) {
      _createDefault();
      _profileBuffer = [_currentProfile];
      saveProfiles();

      return;
    }

    List<dynamic> tempProfileList = json.decode(profilesText);
    _profileBuffer = List<ProfileModel>.from(
        tempProfileList.map((profile) => ProfileModel.fromJson(profile)));

    if (name != null) _setCurrentByName(name);
  }

  void releaseProfiles() => _profileBuffer = null;

  void _setCurrentByName(String name) {
    ProfileModel profileModel =
        _profileBuffer!.firstWhere((element) => element.name == name);
    _currentProfile = profileModel;

    profilePreferences.setString("lastCurrentProfile", _currentProfile.name);

    _profileBuffer = null;
    notifyListeners();
  }

  void _createDefault() {
    ProfileModel defaultProfile = ProfileModel();
    defaultProfile.name = DEFAULT_USERNAME;
    defaultProfile.preferedServer = AppConsts.XCLOUD_SUPPORTED_SERVERS[0];

    defaultProfile.appsHistoric = AppsHistoric();
    defaultProfile.backgroundPreferences =
        BackgroundProfilePreferences(0, null);
    defaultProfile.themePreferences = ThemeProfilePreferences(0);

    _currentProfile = defaultProfile;
  }
}
