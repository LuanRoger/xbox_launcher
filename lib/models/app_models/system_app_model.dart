import 'package:flutter/cupertino.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/controllers/system_app_controller.dart';
import 'package:xbox_launcher/pages/home_page.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';

class SystemAppModel implements AppModel {
  @override
  late String name;
  @override
  AppType appType = AppType.SYSTEM_APP;
  IconData? icon;
  Widget? appHome;

  SystemAppModel();
  factory SystemAppModel.complete(
      {required String name, IconData? icon, Widget? appHome}) {
    SystemAppModel systemAppModel = SystemAppModel();
    systemAppModel.name = name;
    systemAppModel.icon = icon;
    systemAppModel.appHome = appHome;

    return systemAppModel;
  }
  @override
  AppModel fromJson(Map<String, dynamic> json) =>
      SystemAppController.getByName(json["name"] as String);

  @override
  Map<String, dynamic> toJson() => {"name": name, "type": appType.index};
}
