import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/about_configuration_section.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/games_database_configuration_section.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/general_configurations_section.dart';

class ConfigurationsPage extends StatefulWidget {
  const ConfigurationsPage({Key? key}) : super(key: key);

  @override
  State<ConfigurationsPage> createState() => _ConfigurationsPageState();
}

class _ConfigurationsPageState extends State<ConfigurationsPage> {
  late int sectionIndex;

  @override
  void initState() {
    sectionIndex = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
        pane: NavigationPane(
            selected: sectionIndex,
            displayMode: PaneDisplayMode.open,
            onChanged: (index) => setState(() => sectionIndex = index),
            items: [
              PaneItem(
                  title: const Text("General"),
                  icon: const Icon(FluentIcons.settings)),
              PaneItem(
                  title: const Text("Games database"),
                  icon: const Icon(FluentIcons.database)),
              PaneItem(
                  title: const Text("About"),
                  icon: const Icon(FluentIcons.info)),
            ]),
        content: NavigationBody(
          index: sectionIndex,
          children: [
            const GenralConfigurationSection(),
            GamesDatabaseConfigurationSection(),
            const AboutConfigurationSection()
          ],
        ));
  }
}
