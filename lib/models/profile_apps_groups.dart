import 'package:xbox_launcher/models/apps_group.dart';

class ProfileAppsGroups {
  late int lastId;
  List<AppsGroup> groups = List.empty(growable: true);

  ProfileAppsGroups({required this.groups}) {
    if (groups.isNotEmpty) {
      int higherId = 0;
      for (var group in groups) {
        if (group.id! > higherId) higherId = group.id!;
      }
    } else {
      lastId = 0;
    }
  }
  factory ProfileAppsGroups.fromJson(Map<String, dynamic> json) =>
      ProfileAppsGroups(groups: json["groups"]);

  void addNewGroup(AppsGroup appsGroup) {
    appsGroup.id = ++lastId;
    groups.add(appsGroup);
  }

  void removeNewGroup(int id) {
    groups.removeWhere((group) => group.id == id);
  }

  Map<String, dynamic> toJson() => {"lastId": lastId, "groups": groups};
}
