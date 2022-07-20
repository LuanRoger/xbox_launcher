import 'package:xbox_launcher/models/apps_historic.dart';
import 'package:xbox_launcher/models/background_profile_preferences.dart';
import 'package:xbox_launcher/models/external_games_profile_preferences.dart';
import 'package:xbox_launcher/models/theme_data_profile.dart';
import 'package:xbox_launcher/models/video_preferences.dart';

class ProfileModel {
  late int id;
  late String name;
  late String preferedServer;
  String? xcloudGamesJsonPath;
  String? profileImagePath;

  late AppsHistoric appsHistoric;
  late ExternalGamesProfilePreferences externalGamesPreferences;
  late BackgroundProfilePreferences backgroundPreferences;
  late ThemeProfilePreferences themePreferences;
  late VideoPreferences videoPreferences;

  ProfileModel();
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    ProfileModel profileModel = ProfileModel();
    profileModel.id = json["id"];
    profileModel.name = json["name"];
    profileModel.preferedServer = json["preferedServer"];
    profileModel.xcloudGamesJsonPath = json["xcloudGamesJsonPath"];
    profileModel.profileImagePath = json["profileImagePath"];
    profileModel.appsHistoric = AppsHistoric.fromJson(json["appsHistoric"]);
    profileModel.externalGamesPreferences =
        ExternalGamesProfilePreferences.fromJson(json["externalGamesPreferences"]);
    profileModel.backgroundPreferences =
        BackgroundProfilePreferences.fromJson(json["backgroundPreferences"]);
    profileModel.themePreferences =
        ThemeProfilePreferences.fromJson(json["themePreferences"]);
    profileModel.videoPreferences =
        VideoPreferences.fromJson(json["videoPreferences"]);

    return profileModel;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "preferedServer": preferedServer,
        "xcloudGamesJsonPath": xcloudGamesJsonPath,
        "profileImagePath": profileImagePath,
        "appsHistoric": appsHistoric.toJson(),
        "externalGamesPreferences": externalGamesPreferences.toJson(),
        "backgroundPreferences": backgroundPreferences.toJson(),
        "themePreferences": themePreferences.toJson(),
        "videoPreferences": videoPreferences.toJson()
      };
}
