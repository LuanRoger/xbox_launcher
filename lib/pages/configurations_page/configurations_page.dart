import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/about_configuration_section.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/profile_configuration_section.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/cloud_gaming_configuration_section.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/general_configurations_section.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_bar.dart';
import 'package:xbox_launcher/shared/widgets/xbox_page.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class ConfigurationsPage extends XboxPage {
  @override
  List<ShortcutOption> defineMapping(BuildContext context) => [
        ShortcutOption("Back",
            controllerKeyboardPair: ControllerKeyboardPair(
                const SingleActivator(LogicalKeyboardKey.escape),
                ControllerButton.B_BUTTON),
            action: (context) => Navigator.pop(context))
      ];

  @override
  Widget virtualBuild(BuildContext context) {
    final selectedTabState = useState(0);

    return NavigationBar(
        icon: FluentIcons.settings,
        selectedTab: selectedTabState.value,
        paneItems: [
          PaneItem(
              icon: const SizedBox(),
              title: const Text("General"),
              body: const GenralConfigurationSection()),
          PaneItem(
              icon: const SizedBox(),
              title: const Text("Profile"),
              body: const ProfileConfigurationSection()),
          PaneItem(
              icon: const SizedBox(),
              title: const Text("Cloud gaming"),
              body: CloudGamingConfigurationSection()),
          PaneItem(
              icon: const SizedBox(),
              title: const Text("About"),
              body: const AboutConfigurationSection())
        ]);
  }
}
