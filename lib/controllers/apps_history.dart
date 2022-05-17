import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:xbox_launcher/models/app_model.dart';
import 'package:xbox_launcher/models/game_model.dart';
import 'package:xbox_launcher/utils/io_utils.dart';

class AppsHistory extends ChangeNotifier {
  String _APPS_HISTORIC_PATH = "${Directory.current.path}\\apps_historic.json";
  List<AppModel> lastApps = List.empty(growable: true);

  void addApp(AppModel app) {
    AppModel repeatedApp = lastApps.firstWhere(
        (element) => element.name == app.name,
        orElse: () => GameModel("", "", "", "", ""));
    if (repeatedApp.name.isNotEmpty) {
      lastApps.remove(repeatedApp);
    }

    lastApps.insert(0, app);
    _updateList();
    _saveHistoric();
  }

  void _updateList() {
    if (lastApps.length > 7) {
      lastApps.removeAt(lastApps.length - 1);
    }
    notifyListeners();
  }

  void loadHistoric() async {
    String jsonText = await IOUtils.readFile(_APPS_HISTORIC_PATH);
    lastApps = json.decode(jsonText);
    notifyListeners();
  }

  void _saveHistoric() async {
    String jsonText = json.encode(lastApps);
    await IOUtils.writeFile(jsonText, _APPS_HISTORIC_PATH);
  }
}
