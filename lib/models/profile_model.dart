import 'package:xbox_launcher/controllers/apps_historic.dart';
import 'package:xbox_launcher/providers/background_profile_preferences.dart';
import 'package:xbox_launcher/providers/theme_data_profile.dart';

class ProfileModel {
  late String name;
  late String preferedServer;
  String? xcloudGamesJsonPath;
  String? profileImagePath;

  late AppsHistoric appsHistoric;
  late BackgroundProfilePreferences backgroundPreferences;
  late ThemeProfilePreferences themePreferences;

  ProfileModel();
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    ProfileModel profileModel = ProfileModel();
    profileModel.name = json["name"];
    profileModel.preferedServer = json["preferedServer"];
    profileModel.xcloudGamesJsonPath = json["xcloudGamesJsonPath"];
    profileModel.profileImagePath = json["profileImagePath"];
    profileModel.appsHistoric = AppsHistoric.fromJson(json["appsHistoric"]);
    profileModel.backgroundPreferences =
        BackgroundProfilePreferences.fromJson(json["backgroundPreferences"]);
    profileModel.themePreferences =
        ThemeProfilePreferences.fromJson(json["themePreferences"]);

    return profileModel;
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "preferedServer": preferedServer,
        "xcloudGamesJsonPath": xcloudGamesJsonPath,
        "profileImagePath": profileImagePath,
        "appsHistoric": appsHistoric.toJson(),
        "backgroundPreferences": backgroundPreferences.toJson(),
        "themePreferences": themePreferences.toJson()
      };
}
