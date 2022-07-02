import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/pages/add_profile_page.dart';
import 'package:xbox_launcher/pages/configurations_page/sections/configuration_section.dart';
import 'package:xbox_launcher/pages/profile_selector/profile_selector.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/widgets/buttons/icon_text_button.dart';

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
                  onPressed: () => Navigator.push(context,
                      FluentPageRoute(builder: (context) => AddProfilePage())),
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
                  onPressed: () => Navigator.push(
                      context,
                      FluentPageRoute(
                        builder: (context) => ProfileSelector(
                            onProfileSelect: (context, selectedProfile) {
                          Provider.of<ProfileProvider>(context, listen: false)
                              .setCurrentByName(selectedProfile.name);
                        }),
                      )),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
