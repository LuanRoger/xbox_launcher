import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/about_configuration_section.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/games_database_configuration_section.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/general_configurations_section.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateful.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class ConfigurationsPage extends XboxPageStateful {
  ConfigurationsPage({Key? key})
      : super(keyAction: {
          ControllerKeyboardPair(
                  LogicalKeyboardKey.escape, ControllerButton.BACK):
              ((context) => Navigator.pop(context))
        }, key: key);

  @override
  State<StatefulWidget> vitualCreateState() => _ConfigurationsPageState();
}

class _ConfigurationsPageState extends XboxPageState<ConfigurationsPage> {
  late int selectedTab;

  @override
  void initState() {
    selectedTab = 0;
    super.initState();
  }

  @override
  Widget virtualBuild(BuildContext context) {
    //TODO: Replace by NavigationBars
    return NavigationView(
        pane: NavigationPane(
            selected: selectedTab,
            displayMode: PaneDisplayMode.open,
            onChanged: (index) => setState(() => selectedTab = index),
            items: [
              PaneItem(
                  title: const Text("General"),
                  icon: const Icon(FluentIcons.settings),
                  tileColor: ButtonState.all(Colors.yellow)),
              PaneItem(
                  title: const Text("Games database"),
                  icon: const Icon(FluentIcons.database)),
              PaneItem(
                  title: const Text("About"),
                  icon: const Icon(FluentIcons.info)),
            ]),
        content: NavigationBody(
          index: selectedTab,
          children: [
            const GenralConfigurationSection(),
            GamesDatabaseConfigurationSection(),
            const AboutConfigurationSection()
          ],
        ));
  }
}
