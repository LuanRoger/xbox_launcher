import 'package:xbox_launcher/models/app_models/external_game_model.dart';
import 'package:xbox_launcher/utils/loaders/apps_model_loader.dart';

class ExternalGamesProfilePreferences {
  late List<ExternalGameModel> externalGames;

  ExternalGamesProfilePreferences();
  factory ExternalGamesProfilePreferences.fromJson(Map<String, dynamic> json) {
    AppsModelLoader loader = AppsModelLoader();
    ExternalGamesProfilePreferences externalGamesProfilePreferences =
        ExternalGamesProfilePreferences();
    externalGamesProfilePreferences.externalGames = loader
        .recoganizeListExternalGames(json["externalGames"] as List<dynamic>);
    return externalGamesProfilePreferences;
  }
  Map<String, dynamic> toJson() => {"externalGames": externalGames};
}
