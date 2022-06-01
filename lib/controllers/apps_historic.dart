import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_model.dart';
import 'package:xbox_launcher/models/game_model.dart';
import 'package:xbox_launcher/models/system_app_model.dart';
import 'package:xbox_launcher/shared/app_data_files.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';
import 'package:xbox_launcher/utils/io_utils.dart';

class AppsHistoric extends ChangeNotifier {
  List<AppModel> lastApps = List.empty(growable: true);

  void addApp(AppModel app) {
    AppModel repeatedApp = lastApps.firstWhere(
        (element) => element.name == app.name,
        orElse: () => GameModel()..name = "");
    if (repeatedApp.name!.isNotEmpty) {
      lastApps.remove(repeatedApp);
    }

    lastApps.insert(0, app);
    _updateList();
    _saveHistoric();
  }

  void loadHistoric() async {
    String? jsonText =
        await IOUtils.readFile(AppDataFiles.APP_HISTORIC_JSON_FILE_PATH);
    if (jsonText == null) return;

    List<dynamic> jsonDynamicList = json.decode(jsonText);
    lastApps = List<AppModel>.from(jsonDynamicList.map((appModel) {
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
    notifyListeners();
  }

  void _updateList() {
    if (lastApps.length > 7) {
      lastApps.removeAt(lastApps.length - 1);
    }
    notifyListeners();
  }

  void _saveHistoric() async {
    JsonEncoder encoder = JsonEncoder.withIndent(' ' * 4);
    String jsonText =
        encoder.convert(lastApps.map((app) => app.toJson()).toList());

    await IOUtils.writeFile(jsonText, AppDataFiles.APP_HISTORIC_JSON_FILE_PATH);
  }
}
