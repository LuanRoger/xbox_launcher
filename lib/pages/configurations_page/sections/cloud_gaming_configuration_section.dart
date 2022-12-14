import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/enums/xcloud_supported_servers.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart';
import 'package:xbox_launcher/shared/widgets/keyboard/keyboard_button.dart';
import 'package:xbox_launcher/shared/widgets/listbox/listbox.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section_stateless.dart';

class CloudGamingConfigurationSection extends NavigationSectionStateless {
  final TextEditingController jsonUrlTextController = TextEditingController();
  final TextEditingController controllerTest = TextEditingController();

  CloudGamingConfigurationSection({super.key, required super.currentScope})
      : super("Cloud Gaming");

  @override
  List<Widget>? titleActions(BuildContext context) => null;

  @override
  List<Widget> columnItems(BuildContext context) {
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
          child: Consumer<ProfileProvider>(
            builder: (_, value, __) => ListBox(
              XCloudSupportedServers.values
                  .map((item) => ComboBoxItem(
                        child: Text(item.countryCode),
                        value: item.index,
                      ))
                  .toList(),
              placeholder: "Select the server",
              onChange: (newValue) {
                value.preferedServer =
                    XCloudSupportedServers.fromIndex(newValue).countryCode;
              },
            ),
          )),
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
