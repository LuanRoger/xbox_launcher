import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/profile_model.dart';
import 'package:xbox_launcher/pages/add_profile_page.dart';
import 'package:xbox_launcher/pages/manage_profile_page.dart';
import 'package:xbox_launcher/pages/profile_selector/profile_selector.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/widgets/buttons/button_grid.dart';
import 'package:xbox_launcher/shared/widgets/buttons/icon_text_button.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/system_dialog.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section.dart';

class ProfileConfigurationSection extends NavigationSection {
  ProfileConfigurationSection({Key? key}) : super("Profile", key: key);

  Future _removeProfileFlow(ProfileModel toRemove, BuildContext context) {
    return SystemDialog(
        title: "Do you want to remove ${toRemove.name}",
        content:
            "You will lost all the profile info (Configurations, customizations, historic and more...).\n"
            "This action can't be undo.",
        actions: [
          TextButton(
            title: "Continue",
            onPressed: () async {
              bool result =
                  await Provider.of<ProfileProvider>(context, listen: false)
                      .removeProfile(toRemove);

              if (!result) {
                await SystemDialog(
                  title: "A error occurs",
                  content: "You can't delete a profile that is being used.",
                  actions: [
                    TextButton(
                      title: "OK",
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ).show(context);
              }
              //TODO: Else with a success notification

              Navigator.pop(context);
            },
          ),
          TextButton(
            title: "Cancel",
            onPressed: () => Navigator.pop(context),
          )
        ]).show(context);
  }

  @override
  List<Widget>? buildActions(BuildContext context) => null;

  @override
  List<Widget> buildColumnItems(BuildContext context) => [
        Expanded(
          flex: 15,
          child: ButtonGrid(buttons: {
            null: [
              IconTextButton(
                title: "Add profiles",
                icon: FluentIcons.add_friend,
                width: null,
                onPressed: () => Navigator.push(
                    context, FluentPageRoute(builder: (_) => AddProfilePage())),
              ),
              IconTextButton(
                title: "Manage profile",
                icon: FluentIcons.account_management,
                width: null,
                onPressed: () => Navigator.push(context,
                    FluentPageRoute(builder: (_) => ManageProfilePage())),
              ),
            ],
            "": [
              IconTextButton(
                title: "Remove profiles",
                icon: FluentIcons.user_remove,
                width: null,
                onPressed: () => Navigator.push(
                    context,
                    FluentPageRoute(
                        builder: (_) => ProfileSelector(
                            title: "Select to delete.",
                            onProfileSelect: ((context, selectedProfile) async {
                              await _removeProfileFlow(
                                  selectedProfile, context);
                              Navigator.pop(context);
                            })))),
              ),
              IconTextButton(
                title: "Change profile",
                icon: FluentIcons.follow_user,
                width: null,
                onPressed: () => Navigator.push(
                    context,
                    FluentPageRoute(
                      builder: (context) => ProfileSelector(
                          onProfileSelect: (context, selectedProfile) {
                        Provider.of<ProfileProvider>(context, listen: false)
                            .setCurrentByName(selectedProfile.name);
                        Navigator.pop(context);
                      }),
                    )),
              )
            ]
          }),
        )
      ];
}
