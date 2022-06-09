import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/configuration_section.dart';
import 'package:xbox_launcher/shared/widgets/system_button.dart';

class ProfileConfigurationSection extends ConfigurationSection {
  const ProfileConfigurationSection({Key? key}) : super("Profile", key: key);

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
                  "Add profiles",
                  icon: FluentIcons.add_friend,
                  onPressed: () {},
                  height: 75,
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 25,
                child: SystemButton(
                  "Remove profiles",
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
                  "Manage profile",
                  icon: FluentIcons.account_management,
                  onPressed: () {},
                  height: 75,
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 25,
                child: SystemButton(
                  "Change profile",
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
