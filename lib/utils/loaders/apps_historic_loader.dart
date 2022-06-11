import 'dart:convert';

import 'package:xbox_launcher/models/app_model.dart';
import 'package:xbox_launcher/models/game_model.dart';
import 'package:xbox_launcher/models/system_app_model.dart';
import 'package:xbox_launcher/shared/app_data_files.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';
import 'package:xbox_launcher/utils/io_utils.dart';

class AppsHistoricLoader {
  Future<List<AppModel>?> loadHistoric() async {
    String? jsonText =
        await IOUtils.readFile(AppDataFiles.APP_HISTORIC_JSON_FILE_PATH);
    if (jsonText == null) return null;

    List<dynamic> jsonDynamicList = json.decode(jsonText);
    return List<AppModel>.from(jsonDynamicList.map((appModel) {
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
