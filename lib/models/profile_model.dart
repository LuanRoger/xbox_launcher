import 'package:xbox_launcher/providers/background_profile_preferences.dart';
import 'package:xbox_launcher/providers/theme_data_profile.dart';

class ProfileModel {
  late String name;
  late String preferedServer;
  String? profileImagePath;

  late BackgroundProfilePreferences backgroundPreferences;
  late ThemeProfilePreferences themePreferences;

  ProfileModel();
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    ProfileModel profileModel = ProfileModel();
    profileModel.name = json["name"];
    profileModel.preferedServer = json["preferedServer"];
    profileModel.profileImagePath = json["profileImagePath"];
    profileModel.backgroundPreferences =
        BackgroundProfilePreferences.fromJson(json["backgroundPreferences"]);
    profileModel.themePreferences =
        ThemeProfilePreferences.fromJson(json["themePreferences"]);

    return profileModel;
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "preferedServer": preferedServer,
        "profileImagePath": profileImagePath,
        "backgroundPreferences": backgroundPreferences,
        "themePreferences": themePreferences.toJson()
      };
}
