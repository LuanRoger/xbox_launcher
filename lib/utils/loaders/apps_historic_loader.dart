import 'package:xbox_launcher/models/app_model.dart';
import 'package:xbox_launcher/models/game_model.dart';
import 'package:xbox_launcher/models/system_app_model.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';

class AppsHistoricLoader {
  List<AppModel> recoganizeAppList(List<dynamic> appsList) {
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
        default:
          app = null;
          break;
      }

      return app;
    }));
  }
}
