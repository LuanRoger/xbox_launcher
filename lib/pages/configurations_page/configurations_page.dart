import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:xbox_launcher/controllers/keyboard_controller_action_manipulator.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/about_configuration_section.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/profile_configuration_section.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/cloud_gaming_configuration_section.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/general_configurations_section.dart';
import 'package:xbox_launcher/shared/widgets/models/navigation_item.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateful.dart';
import 'package:xbox_launcher/shared/widgets/navigation_bar.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class ConfigurationsPage extends XboxPageStateful {
  ConfigurationsPage({Key? key})
      : super(pageKeysAction: {
          ControllerKeyboardPair(
              const SingleActivator(LogicalKeyboardKey.escape),
              ControllerButton.B_BUTTON): ((context) => Navigator.pop(context))
        }, key: key);

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
  void defineMapping(BuildContext context) {
    KeyboardControllerActionManipulator.mapKeyboardControllerActions(
        context, widget.pageKeysAction!);
  }

  @override
  Widget virtualBuild(BuildContext context) {
    return NavigationBar(
      icon: FluentIcons.settings,
      selectedTab: selectedTab,
      paneItems: [
        NavigationItem("General"),
        NavigationItem("Profile"),
        NavigationItem("Cloud gaming"),
        NavigationItem("About")
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
