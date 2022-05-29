import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/configuration_section.dart';
import 'package:xbox_launcher/providers/xcloud_game_database_provider.dart';
import 'package:xbox_launcher/shared/widgets/system_button.dart';

class CloudGamingConfigurationSection extends ConfigurationSection {
  final TextEditingController jsonUrlTextController = TextEditingController();
  final servers = ["en_US", "pt_BR"];

  CloudGamingConfigurationSection({Key? key}) : super("Cloud Gaming", key: key);

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
            header: "JSON file path:",
            controller: jsonUrlTextController,
          ),
        ),
        const Spacer(),
        InfoLabel(
          label: "XCloud server:",
          child: Combobox<String>(
            isExpanded: true,
            placeholder: const Text("Select the server"),
            items: servers
                .map((item) => ComboboxItem(
                      child: Text(item),
                      value: item,
                    ))
                .toList(),
            value: servers[0],
            onChanged: (value) {},
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
