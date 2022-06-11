import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/configuration_section.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_consts.dart';
import 'package:xbox_launcher/shared/widgets/system_button.dart';

class CloudGamingConfigurationSection extends ConfigurationSection {
  final TextEditingController jsonUrlTextController = TextEditingController();
  String? selectedServer;

  CloudGamingConfigurationSection({Key? key}) : super("Cloud Gaming", key: key);

  @override
  Widget virtualBuild(BuildContext context) {
    jsonUrlTextController.text =
        Provider.of<ProfileProvider>(context, listen: false)
                .xcloudGamesJsonPath ??
            "";

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
            items: AppConsts.xcloudSupportedServers
                .map((item) => ComboboxItem(
                      child: Text(item),
                      value: item,
                    ))
                .toList(),
            value: AppConsts.xcloudSupportedServers.firstWhere((element) =>
                element ==
                Provider.of<ProfileProvider>(context, listen: false)
                    .preferedServer),
            onChanged: (newValue) => selectedServer = newValue,
          ),
        ),
        const Spacer(),
        Flexible(
          flex: 10,
          child: SystemButton("Confirm", width: 170, height: 70, onPressed: () {
            context.read<ProfileProvider>().xcloudGamesJsonPath =
                jsonUrlTextController.text;

            if (selectedServer != null) {
              context.read<ProfileProvider>().preferedServer = selectedServer!;
            }
          }),
        )
      ],
    );
  }
}
