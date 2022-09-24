import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/about_configuration_section.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/profile_configuration_section.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/cloud_gaming_configuration_section.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/general_configurations_section.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateful.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_bar.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class ConfigurationsPage extends XboxPageStateful {
  const ConfigurationsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConfigurationsPageState();
}

class _ConfigurationsPageState extends XboxPageState<ConfigurationsPage> {
  late int selectedTab;

  @override
  void initState() {
    selectedTab = 0;
    super.initState();
  }

  @override
  Map<ControllerKeyboardPair, void Function(BuildContext)>? defineMapping(
          BuildContext context) =>
      {
        ControllerKeyboardPair(const SingleActivator(LogicalKeyboardKey.escape),
            ControllerButton.B_BUTTON): ((context) => Navigator.pop(context))
      };

  @override
  Widget virtualBuild(BuildContext context) {
    return NavigationBar(
      icon: FluentIcons.settings,
      selectedTab: selectedTab,
      paneItems: [
        PaneItem(icon: const SizedBox(), title: const Text("General")),
        PaneItem(icon: const SizedBox(), title: const Text("Profile")),
        PaneItem(icon: const SizedBox(), title: const Text("Cloud gaming")),
        PaneItemSeparator(),
        PaneItem(icon: const SizedBox(), title: const Text("About"))
      ],
      bodyItems: [
        const GenralConfigurationSection(),
        const ProfileConfigurationSection(),
        CloudGamingConfigurationSection(),
        const AboutConfigurationSection()
      ],
    );
  }
}
