// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/utils/loaders/apps_model_loader.dart';
import 'package:collection/collection.dart';

class AppsGroup {
  int? id;
  String groupName;
  final List<AppModel> apps;

  AppsGroup({required this.groupName, required this.apps});
  factory AppsGroup.fromJson(Map<String, dynamic> json) {
    AppsModelLoader loader = AppsModelLoader();
    AppsGroup appsGroup = AppsGroup(
        groupName: json["groupName"] as String,
        apps: loader.recoganizeGenericApps(json["apps"]));
    appsGroup.id = json["id"] as int;

    return appsGroup;
  }

  void addNewApp(AppModel appModel) {
    if (apps.firstWhereOrNull((app) => appModel.name == app.name) != null)
      return;

    apps.add(appModel);
  }

  void removeApp(String appName) {
    apps.removeWhere((app) => app.name == appName);
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "groupName": groupName, "apps": apps};
}
