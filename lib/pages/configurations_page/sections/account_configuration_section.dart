import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/configuration_section.dart';
import 'package:xbox_launcher/shared/widgets/system_button.dart';

class AccountConfigurationSection extends ConfigurationSection {
  const AccountConfigurationSection({Key? key}) : super("Account", key: key);

  @override
  Widget virtualBuild(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 0,
          child: Row(
            children: [
              Expanded(
                flex: 25,
                child: SystemButton(
                  "Add accounts",
                  icon: FluentIcons.add_friend,
                  onPressed: () {},
                  height: 75,
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 25,
                child: SystemButton(
                  "Remove accounts",
                  icon: FluentIcons.user_remove,
                  onPressed: () {},
                  height: 75,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Flexible(
          flex: 25,
          child: Row(
            children: [
              Expanded(
                flex: 25,
                child: SystemButton(
                  "Manage account",
                  icon: FluentIcons.account_management,
                  onPressed: () {},
                  height: 75,
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 25,
                child: SystemButton(
                  "Change account",
                  icon: FluentIcons.follow_user,
                  onPressed: () {},
                  height: 75,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
