import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/models/apps_group.dart';
import 'package:collection/collection.dart';

class ProfileAppsGroups {
  late int lastId;
  List<AppsGroup> groups = List<AppsGroup>.empty(growable: true);

  ProfileAppsGroups({required this.groups}) {
    if (groups.isNotEmpty) {
      int higherId = 0;
      for (var group in groups) {
        if (group.id! > higherId) higherId = group.id!;
      }
      lastId = higherId;
    } else {
      lastId = 0;
    }
  }
  factory ProfileAppsGroups.fromJson(Map<String, dynamic> json) {
    List<AppsGroup> appGroups = List.empty(growable: true);
    for (var groups in json["groups"]) {
      appGroups.add(AppsGroup.fromJson(groups));
    }
    return ProfileAppsGroups(groups: appGroups);
  }

  AppsGroup? getGroupById(int id) =>
      groups.firstWhereOrNull((group) => group.id == id);

  void addNewGroup(AppsGroup appsGroup) {
    appsGroup.id = ++lastId;
    groups.add(appsGroup);
  }

  void addAppToGroups(int id, AppModel appModel) {
    getGroupById(id)?.addNewApp(appModel);
  }

  void renameGroup(int id, String newName) {
    getGroupById(id)?.groupName = newName;
  }

  void removeNewGroup(int id) {
    groups.remove(getGroupById(id));
  }

  void removeAppFromGroup(int groupId, AppModel appModel) {
    getGroupById(groupId)?.apps.remove(appModel);
  }

  Map<String, dynamic> toJson() => {"lastId": lastId, "groups": groups};
}
