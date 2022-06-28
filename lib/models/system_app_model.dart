import 'package:flutter/cupertino.dart';
import 'package:xbox_launcher/models/app_model.dart';
import 'package:xbox_launcher/controllers/system_app_controller.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';

class SystemAppModel implements AppModel {
  @override
  late String? name;
  @override
  AppType appType = AppType.SYSTEM_APP;
  IconData? icon;
  Widget? appHome;

  SystemAppModel({this.name, this.icon, this.appHome});

  @override
  AppModel fromJson(Map<String, dynamic> json) =>
      SystemAppController.getByName(json["name"] as String);

  @override
  Map<String, dynamic> toJson() => {"name": name, "type": appType.index};
}
