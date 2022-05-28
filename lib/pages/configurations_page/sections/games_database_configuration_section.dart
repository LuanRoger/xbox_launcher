import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/configuration_section.dart';
import 'package:xbox_launcher/providers/xcloud_game_database_provider.dart';
import 'package:xbox_launcher/shared/widgets/system_button.dart';

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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 0,
          child: TextBox(
            header: "JSON File Path",
            controller: jsonUrlTextController,
          ),
        ),
        const Spacer(),
        Flexible(
          flex: 10,
          child: SystemButton("Confirm",
              width: 170,
              height: 70,
              onPressed: () => Provider.of<XcloudGameDatabaseProvider>(context,
                      listen: false)
                  .xcloudJsonDbPath = jsonUrlTextController.text),
        )
      ],
    );
  }
}
