import 'package:xbox_launcher/models/app_models/app_model.dart';

class AppsGroup {
  int? id;
  String groupName;
  final List<AppModel> apps;

  AppsGroup({required this.groupName, required this.apps});
  factory AppsGroup.fromJson(Map<String, dynamic> json) =>
      AppsGroup(groupName: json["groupName"], apps: json["apps"])
        ..id = json["id"];

  void addNewApp(AppModel appModel) {
    apps.add(appModel);
  }

  void removeApp(String appName) {
    apps.removeWhere((app) => app.name == appName);
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "groupName": groupName, "apps": apps};
}
