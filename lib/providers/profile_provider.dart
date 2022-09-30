import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/models/apps_group.dart';
import 'package:xbox_launcher/models/profile_model.dart';
import 'package:xbox_launcher/models/profile_update_info.dart';
import 'package:xbox_launcher/utils/loaders/profile_loader.dart';

class ProfileProvider extends ChangeNotifier {
  late SharedPreferences profilePreferences;
  late ProfileModel _currentProfile;
  late ProfileLoader profileLoader;

  Future init() async {
    profilePreferences = await SharedPreferences.getInstance();
    profileLoader = ProfileLoader();

    if (!(await profileLoader.loadProfiles())) {
      profileLoader.addNewProfile(ProfileModel.createDefault());
      profilePreferences.remove("lastCurrentProfile");
    }

    await setCurrentById(profilePreferences.getInt("lastCurrentProfile") ?? 0);

    await _currentProfile.videoPreferences.init();
  }

  List<ProfileModel>? get profilesList =>
      profileLoader.profileBuffer ?? List<ProfileModel>.empty();

  Future addNewProfile(ProfileModel newProfile) async {
    profileLoader.addNewProfile(newProfile);

    await saveProfiles();
  }

  void updateCurrentProfile(ProfileUpdateInfo newProfileInfo) {
    _currentProfile.name = newProfileInfo.name;
    _currentProfile.profileImagePath = newProfileInfo.profileImagePath;

    notifyListeners();
    saveProfile();
  }

  Future<bool> removeProfile(ProfileModel toRemove) async {
    if (_currentProfile.hashCode == toRemove.hashCode ||
        profilesList!.length <= 1) return false;

    bool result = profileLoader.profileBuffer!.remove(toRemove);

    await saveProfiles();
    return result;
  }

  String get name => _currentProfile.name;
  set name(String name) {
    _currentProfile.name = name;

    notifyListeners();
    saveProfile();
  }

  String get preferedServer => _currentProfile.preferedServer;
  set preferedServer(String preferedServer) {
    _currentProfile.preferedServer = preferedServer;

    saveProfile();
  }

  String? get xcloudGamesJsonPath => _currentProfile.xcloudGamesJsonPath;
  set xcloudGamesJsonPath(String? xcloudGamesJsonPath) {
    _currentProfile.xcloudGamesJsonPath = xcloudGamesJsonPath;

    saveProfile();
  }

  String? get profileImagePath => _currentProfile.profileImagePath;
  set profileImagePath(String? profileImagePath) {
    _currentProfile.profileImagePath = profileImagePath;

    notifyListeners();
    saveProfile();
  }

  List<AppModel> get lastApps => _currentProfile.appsHistoric.lastApps;
  void addAppToHistory(AppModel appModel) {
    _currentProfile.appsHistoric.addApp(appModel);

    notifyListeners();
    saveProfile();
  }

  void removeAppFromHistory(AppModel appModel) {
    _currentProfile.appsHistoric.removeApp(appModel);

    notifyListeners();
    saveProfile();
  }

  List<AppsGroup> get appsGroups => _currentProfile.appsGroups.groups;
  void addAppsGroup(AppsGroup appsGroup) {
    _currentProfile.appsGroups.addNewGroup(appsGroup);

    notifyListeners();
    saveProfile();
  }

  void addAppToGroups(int id, AppModel appModel) {
    _currentProfile.appsGroups.addAppToGroups(id, appModel);

    notifyListeners();
    saveProfile();
  }

  void removeAppsGroup(int groupId) {
    _currentProfile.appsGroups.removeNewGroup(groupId);
  }

  void removeAppFromGroup(int groupId, AppModel appModel) {
    _currentProfile.appsGroups.removeAppFromGroup(groupId, appModel);

    notifyListeners();
    saveProfile();
  }

  int get preferedColorIndex =>
      _currentProfile.themePreferences.preferedColorIndex;
  set preferedColorIndex(int preferedColorIndex) {
    _currentProfile.themePreferences.preferedColorIndex = preferedColorIndex;

    notifyListeners();
    saveProfile();
  }

  int get backgroundColorIndex =>
      _currentProfile.backgroundPreferences.backgroundColorIndex;
  set backgroundColorIndex(int backgroundColorIndex) {
    _currentProfile.backgroundPreferences.backgroundColorIndex =
        backgroundColorIndex;

    notifyListeners();
    saveProfile();
  }

  String? get imageBackgroundPath =>
      _currentProfile.backgroundPreferences.imageBackgroundPath;
  set imageBackgroundPath(String? imageBackgroundPath) {
    _currentProfile.backgroundPreferences.imageBackgroundPath =
        imageBackgroundPath;

    notifyListeners();
    saveProfile();
  }

  bool get preferenceByImage =>
      _currentProfile.backgroundPreferences.preferenceByImage;
  set preferenceByImage(bool preferenceByImage) {
    _currentProfile.backgroundPreferences.preferenceByImage = preferenceByImage;

    notifyListeners();
    saveProfile();
  }

  Brightness get brightness => _currentProfile.themePreferences.brightness;
  Color get accentColor => _currentProfile.themePreferences.accentColor;
  String get fontFamily => _currentProfile.themePreferences.fontFamily;
  FocusThemeData get focusThemeData =>
      _currentProfile.themePreferences.focusThemeData;
  Color get solidColorBackground =>
      _currentProfile.backgroundPreferences.solidColorBackground;

  void resetBackground() => _currentProfile.backgroundPreferences.reset();

  bool get fullscreen => _currentProfile.videoPreferences.fullscreen;
  set fullscreen(bool fullscreen) {
    _currentProfile.videoPreferences.fullscreen = fullscreen;

    notifyListeners();
    saveProfile();
  }

  void saveProfile() => profileLoader.saveProfile(_currentProfile);
  Future saveProfiles() => profileLoader.saveProfiles();

  Future setCurrentById(int id) async {
    ProfileModel profileModel =
        profileLoader.profileBuffer!.firstWhere((element) => element.id == id);
    _currentProfile = profileModel;

    await profilePreferences.setInt("lastCurrentProfile", _currentProfile.id);

    notifyListeners();
  }

  ProfileModel generateNewDumyProfile() {
    ProfileModel profileModel = ProfileModel.createDefault();
    profileModel.id = profileLoader.higherId + 1;

    return profileModel;
  }
}
