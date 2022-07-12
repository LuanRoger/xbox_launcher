import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/system_app_model.dart';
import 'package:xbox_launcher/pages/configurations_page/configurations_page.dart';
import 'package:xbox_launcher/pages/x360_game_page.dart';

class SystemAppController {
  static final List<SystemAppModel> systemApps = [
    SystemAppModel(
        name: "Configurations",
        icon: FluentIcons.settings,
        appHome: ConfigurationsPage()),
    SystemAppModel(
        name: "Xbox 360", icon: FluentIcons.game, appHome: const X360GamePage())
  ];

  static SystemAppModel getByName(String name) =>
      systemApps.firstWhere((element) => element.name == name);
}
