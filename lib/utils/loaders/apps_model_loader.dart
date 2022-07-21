import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/models/app_models/external_game_model.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/models/app_models/system_app_model.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';

class AppsModelLoader {
  List<AppModel> recoganizeNonConcreateApp(List<dynamic> appsList) {
    return List<AppModel>.from(appsList.map((appModel) {
      AppModel? app;
      switch (AppType.values
          .firstWhere((element) => element.index == appModel["type"] as int)) {
        case AppType.GAME:
          app = GameModel().fromJson(appModel);
          break;
        case AppType.SYSTEM_APP:
          app = SystemAppModel().fromJson(appModel);
          break;
        case AppType.EXTERNAL_APP:
          app = ExternalGameModel().fromJson(appModel);
          break;
      }

      return app;
    }).toList());
  }

  List<GameModel> recoganizeListGameModel(List<dynamic> appsList) =>
      List<GameModel>.from(
          appsList.map((model) => GameModel().fromJson(model)).toList());

  List<SystemAppModel> recoganizeListSystemApp(List<dynamic> appList) =>
      List<SystemAppModel>.from(
          appList.map((model) => SystemAppModel().fromJson(model)));

  List<ExternalGameModel> recoganizeListExternalGames(List<dynamic> appList) =>
      List<ExternalGameModel>.from(
          appList.map((model) => ExternalGameModel().fromJson(model)).toList());
}
