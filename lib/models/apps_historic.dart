import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/models/app_models/system_app_model.dart';
import 'package:xbox_launcher/utils/loaders/apps_model_loader.dart';

class AppsHistoric {
  List<AppModel> lastApps = List<SystemAppModel>.empty(growable: true);

  AppsHistoric();
  factory AppsHistoric.fromJson(Map<String, dynamic> json) {
    AppsModelLoader loader = AppsModelLoader();
    AppsHistoric appsHistoric = AppsHistoric();
    appsHistoric.lastApps =
        loader.recoganizeNonConcreateApp(json["lastApps"] as List<dynamic>);

    return appsHistoric;
  }
  Map<String, dynamic> toJson() => {"lastApps": lastApps};

  void addApp(AppModel appModel) {
    AppModel? repeatedApp = lastApps.firstWhere(
        (app) => app.name == appModel.name,
        orElse: () => GameModel()..name = "");
    if (repeatedApp.name.isNotEmpty) {
      lastApps.remove(repeatedApp);
    }

    lastApps.insert(0, appModel);
    _updateList();
  }

  void removeApp(AppModel appModel) =>
      lastApps.removeWhere((app) => app.name == appModel.name);

  void _updateList() {
    if (lastApps.length <= 7) return;

    lastApps.removeAt(lastApps.length - 1);
  }
}
