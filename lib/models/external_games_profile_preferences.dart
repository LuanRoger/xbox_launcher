import 'package:xbox_launcher/models/app_model.dart';
import 'package:xbox_launcher/utils/loaders/apps_model_loader.dart';

class ExternalGamesProfilePreferences {
  List<AppModel> externalGames = List.empty(growable: true);

  ExternalGamesProfilePreferences();
  factory ExternalGamesProfilePreferences.fromJson(Map<String, dynamic> json) {
    AppsModelLoader loader = AppsModelLoader();
    ExternalGamesProfilePreferences externalGamesProfilePreferences =
        ExternalGamesProfilePreferences();
    externalGamesProfilePreferences.externalGames =
        loader.recoganizeAppList(json["externalGames"] as List<dynamic>);
    return externalGamesProfilePreferences;
  }
  Map<String, dynamic> toJson() => {"externalGames": externalGames};
}
