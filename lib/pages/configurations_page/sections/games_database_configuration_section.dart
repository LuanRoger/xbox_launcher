import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/configuration_section.dart';

class GamesDatabaseConfigurationSection extends ConfigurationSection {
  final TextEditingController jsonUrlTextController = TextEditingController();

  GamesDatabaseConfigurationSection({Key? key})
      : super("Games database", key: key);

  @override
  Widget virtualBuild(BuildContext context) {
    return Column(
      children: const [
        TextBox(
          header: "JSON File Url",
        )
      ],
    );
  }
}
