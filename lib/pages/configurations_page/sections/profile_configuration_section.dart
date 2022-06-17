import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/configuration_section.dart';
import 'package:xbox_launcher/shared/widgets/buttons/icon_text_button.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_button.dart';

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
                child: IconTextButton(
                  title: "Add profiles",
                  icon: FluentIcons.add_friend,
                  onPressed: () {},
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 25,
                child: IconTextButton(
                  title: "Remove profiles",
                  icon: FluentIcons.user_remove,
                  onPressed: () {},
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
                child: IconTextButton(
                  title: "Manage profile",
                  icon: FluentIcons.account_management,
                  onPressed: () {},
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 25,
                child: IconTextButton(
                  title: "Change profile",
                  icon: FluentIcons.follow_user,
                  onPressed: () {},
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
