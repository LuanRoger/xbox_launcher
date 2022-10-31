import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_models/system_app_model.dart';
import 'package:xbox_launcher/pages/configurations_page/configurations_page.dart';

class SystemAppController {
  static final List<SystemAppModel> systemApps = [
    SystemAppModel.complete(
        name: "Configurations",
        icon: FluentIcons.settings,
        appHome: const ConfigurationsPage()),
  ];

  static SystemAppModel getByName(String name) =>
      systemApps.firstWhere((element) => element.name == name);
}
