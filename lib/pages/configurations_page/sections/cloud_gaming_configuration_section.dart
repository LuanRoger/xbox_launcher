import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/configuration_section.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_consts.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_button.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart'
    as XButtons;

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
          child: StatefulBuilder(
            builder: ((_, setState) => Consumer<ProfileProvider>(
                  builder: (_, value, __) => Combobox<String>(
                    isExpanded: true,
                    placeholder: const Text("Select the server"),
                    items: AppConsts.XCLOUD_SUPPORTED_SERVERS
                        .map((item) => ComboboxItem(
                              child: Text(item),
                              value: item,
                            ))
                        .toList(),
                    value: AppConsts.XCLOUD_SUPPORTED_SERVERS.firstWhere(
                        (element) => element == value.preferedServer),
                    onChanged: (newValue) {
                      value.preferedServer = newValue!;
                      setState(() {});
                    },
                  ),
                )),
          ),
        ),
        const Spacer(),
        Flexible(
          flex: 10,
          child: XButtons.TextButton(
              title: "Confirm",
              onPressed: () {
                context.read<ProfileProvider>().xcloudGamesJsonPath =
                    jsonUrlTextController.text;
              }),
        )
      ],
    );
  }
}
