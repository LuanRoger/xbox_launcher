import 'dart:ffi';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/external_file_picker.dart';
import 'package:xbox_launcher/models/profile_update_info.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart'
    as xbox_button;
import 'package:xbox_launcher/shared/widgets/dialogs/system_dialog.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateful.dart';
import 'package:xbox_launcher/shared/widgets/profile_avatar_button.dart';

class ManageProfilePage extends XboxPageStateful {
  ManageProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> vitualCreateState() => _ManageProfilePageState();
}

class _ManageProfilePageState extends State<ManageProfilePage> {
  late TextEditingController textController;
  String? _tempProfileImagePath;
  late bool firtEntry;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    firtEntry = true;
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  void getProfileInfo(BuildContext context) {
    var profileProvider = context.read<ProfileProvider>();

    textController.text = profileProvider.name;
    _tempProfileImagePath = profileProvider.profileImagePath;
  }

  Future<bool> confirmChanges(
      BuildContext context, ProfileUpdateInfo newProfileInfo) async {
    bool exit = false;

    await SystemDialog(
        title: "Confirm changes?",
        content: "Do you want to confirm those changes?",
        actions: [
          xbox_button.TextButton(
            title: "Yes",
            onPressed: () {
              Provider.of<ProfileProvider>(context, listen: false)
                  .updateCurrentProfile(newProfileInfo);

              Navigator.pop(context);
              exit = true;
            },
          ),
          xbox_button.TextButton(
              title: "No", onPressed: () => Navigator.pop(context))
        ]).show(context);

    return exit;
  }

  @override
  Widget build(BuildContext context) {
    if (firtEntry) {
      getProfileInfo(context);
      setState(() => firtEntry = false);
    }

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
                              setState(
                                  () => _tempProfileImagePath = tempImagePath);
                            },
                            radiusSize: 100,
                            profileImagePath: _tempProfileImagePath)),
                    const Spacer(),
                    Expanded(
                      flex: 15,
                      child: TextBox(
                        header: "Profile name:",
                        headerStyle: AppTextStyle.ADD_PROFILE_TEXT_HEADER,
                        maxLength: 30,
                        maxLines: 1,
                        minLines: 1,
                        controller: textController,
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
                        title: "Confirm changes",
                        onPressed: () async {
                          ProfileUpdateInfo profileUpdateInfo =
                              ProfileUpdateInfo(
                                  textController.text, _tempProfileImagePath);

                          bool response =
                              await confirmChanges(context, profileUpdateInfo);
                          if (response) Navigator.pop(context);
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
