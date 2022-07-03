import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/external_file_picker.dart';
import 'package:xbox_launcher/models/profile_model.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart'
    as xbox_button;
import 'package:xbox_launcher/shared/widgets/dialogs/system_dialog.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateful.dart';
import 'package:xbox_launcher/shared/widgets/profile_avatar_button.dart';

class AddProfilePage extends XboxPageStateful {
  AddProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> vitualCreateState() => _AddProfilePageState();
}

class _AddProfilePageState extends XboxPageState<AddProfilePage> {
  String? _profileImagePath;
  late final TextEditingController profileNameController;

  @override
  void initState() {
    super.initState();
    profileNameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    profileNameController.dispose();
  }

  bool _isProfileNameValid() => profileNameController.text.isNotEmpty;
  Future changeToNewProfileDialog(BuildContext context) {
    return SystemDialog(
        title: "Change to new profile?",
        content:
            "Do you want to change to the profile ${profileNameController.text} now?",
        actions: [
          xbox_button.TextButton(
            title: "Yes",
            onPressed: () async {
              await Provider.of<ProfileProvider>(context, listen: false)
                  .setCurrentByName(profileNameController.text);

              Navigator.pop(context);
            },
          ),
          xbox_button.TextButton(
              title: "No", onPressed: () => Navigator.pop(context))
        ]).show(context);
  }

  @override
  Widget virtualBuild(BuildContext context) {
    return Container(
      color: AppColors.DARK_BG,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        flex: 15,
                        child: ProfileAvatarButton(
                            accentColor: AppColors.GREEN,
                            onPressed: () async {
                              String? tempImagePath =
                                  await ExternalFilePicker.getImagePath();
                              setState(() => _profileImagePath = tempImagePath);
                            },
                            radiusSize: 100,
                            profileImagePath: _profileImagePath)),
                    const Spacer(),
                    Expanded(
                      flex: 15,
                      child: TextBox(
                        header: "Profile name:",
                        headerStyle: AppTextStyle.ADD_PROFILE_TEXT_HEADER,
                        maxLength: 30,
                        maxLines: 1,
                        minLines: 1,
                        controller: profileNameController,
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    xbox_button.TextButton(
                        title: "Confirm",
                        onPressed: () async {
                          final ProfileProvider profileProvider =
                              Provider.of<ProfileProvider>(context,
                                  listen: false);

                          ProfileModel newProfileModel =
                              profileProvider.createDefault();
                          if (_isProfileNameValid()) {
                            newProfileModel.name = profileNameController.text;
                          } else {
                            //TODO: Made alarm system
                            print("The name can't be empty");
                            return;
                          }
                          newProfileModel.profileImagePath = _profileImagePath;

                          profileProvider.addNewProfile(newProfileModel);

                          await changeToNewProfileDialog(context);
                          Navigator.pop(context);
                        }),
                    xbox_button.TextButton(
                      title: "Cancel",
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
