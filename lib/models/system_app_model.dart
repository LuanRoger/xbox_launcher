import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_model.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';

class SystemAppModel implements AppModel {
  @override
  String name;
  @override
  AppType appType = AppType.SYSTEM_APP;
  IconData icon;
  void Function(BuildContext)? onClick;

  SystemAppModel(this.name, this.icon, {this.onClick});

  factory SystemAppModel.fromJson(Map<String, dynamic> json) =>
      SystemAppModel(json["name"], json["icon"]);
  Map<String, dynamic> toJson() =>
      {"name": name, "appType": appType, "icon": icon};
}
