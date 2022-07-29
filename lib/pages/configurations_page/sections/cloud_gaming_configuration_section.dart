import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_consts.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart';
import 'package:xbox_launcher/shared/widgets/keyboard/keyboard_button.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section.dart';

class CloudGamingConfigurationSection extends NavigationSection {
  final TextEditingController jsonUrlTextController = TextEditingController();
  final TextEditingController controllerTest = TextEditingController();
  String? selectedServer;

  CloudGamingConfigurationSection({Key? key}) : super("Cloud Gaming", key: key);

  @override
  List<Widget>? buildActions(BuildContext context) => null;

  @override
  List<Widget> buildColumnItems(BuildContext context) {
    jsonUrlTextController.text =
        Provider.of<ProfileProvider>(context, listen: false)
                .xcloudGamesJsonPath ??
            "";

    return [
      Flexible(
        flex: 0,
        child: InfoLabel(
          label: "JSON file path:",
          child: KeyboardButton(
            placeholder: "JSON file path",
            controller: jsonUrlTextController,
          ),
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
                  value: AppConsts.XCLOUD_SUPPORTED_SERVERS
                      .firstWhere((element) => element == value.preferedServer),
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
        child: TextButton(
            title: "Confirm",
            onPressed: () {
              context.read<ProfileProvider>().xcloudGamesJsonPath =
                  jsonUrlTextController.text;
            }),
      )
    ];
  }
}
