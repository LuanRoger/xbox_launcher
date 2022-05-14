import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/configuration_section.dart';
import 'package:xbox_launcher/providers/xcloud_game_database_provider.dart';

class GamesDatabaseConfigurationSection extends ConfigurationSection {
  final TextEditingController jsonUrlTextController = TextEditingController();

  GamesDatabaseConfigurationSection({Key? key})
      : super("Games database", key: key);

  @override
  Widget virtualBuild(BuildContext context) {
    jsonUrlTextController.text =
        Provider.of<XcloudGameDatabaseProvider>(context, listen: false)
            .xcloudJsonDbPath;
            
    return Column(
      children: [
        TextBox(
          header: "JSON File Url",
          controller: jsonUrlTextController,
        ),
        Button(
            child: const Text("Confirm"),
            onPressed: () =>
                Provider.of<XcloudGameDatabaseProvider>(context, listen: false)
                    .xcloudJsonDbPath = jsonUrlTextController.text)
      ],
    );
  }
}
