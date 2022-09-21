import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/external_file_picker.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/models/profile_update_info.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/alert_bar/alert_bar_overlay.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/system_dialog.dart';
import 'package:xbox_launcher/shared/widgets/keyboard/keyboard_button.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateful.dart';
import 'package:xbox_launcher/shared/widgets/buttons/profile_avatar_button.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class ManageProfilePage extends XboxPageStateful {
  const ManageProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ManageProfilePageState();
}

class _ManageProfilePageState extends XboxPageState<ManageProfilePage> {
  late final TextEditingController profileNameTextController;
  String? _tempProfileImagePath;
  late bool firstEntry;
  bool _isProfileNameValid() => profileNameTextController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    profileNameTextController = TextEditingController();
    firstEntry = true;
  }

  @override
  void dispose() {
    super.dispose();
    profileNameTextController.dispose();
  }

  @override
  Map<ControllerKeyboardPair, void Function(BuildContext)>? defineMapping(
          BuildContext context) =>
      {
        ControllerKeyboardPair(const SingleActivator(LogicalKeyboardKey.escape),
            ControllerButton.B_BUTTON): ((context) => Navigator.pop(context))
      };

  void getProfileInfo(BuildContext context) {
    var profileProvider = context.read<ProfileProvider>();

    profileNameTextController.text = profileProvider.name;
    _tempProfileImagePath = profileProvider.profileImagePath;
  }

  Future<bool> confirmChanges(
      BuildContext context, ProfileUpdateInfo newProfileInfo) async {
    bool exit = false;

    await SystemDialog(
        title: "Confirm changes?",
        content: "Do you want to confirm those changes?",
        actions: [
          TextButton(
            title: "Yes",
            onPressed: () {
              Provider.of<ProfileProvider>(context, listen: false)
                  .updateCurrentProfile(newProfileInfo);

              Navigator.pop(context);
              exit = true;
            },
          ),
          TextButton(title: "No", onPressed: () => Navigator.pop(context))
        ]).show(context);

    return exit;
  }

  @override
  Widget virtualBuild(BuildContext context) {
    if (firstEntry) {
      getProfileInfo(context);
      setState(() => firstEntry = false);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Flexible(
                child: Text(
              "Manage profile",
              style: AppTextStyle.ADD_UPDATE_PROFILE_PAGE_TITLE,
            )),
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
                    child: InfoLabel(
                      label: "Profile name:",
                      child: KeyboardButton(
                        placeholder: "Profile name",
                        controller: profileNameTextController,
                        maxLenght: 30,
                      ),
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
                  TextButton(
                      title: "Confirm changes",
                      onPressed: () async {
                        if (!_isProfileNameValid()) {
                          AlertBarOverlay("Can't be empty.",
                                  "The Profile name can't be empty.",
                                  severity: InfoBarSeverity.error)
                              .show(context);
                          return;
                        }

                        ProfileUpdateInfo profileUpdateInfo = ProfileUpdateInfo(
                            profileNameTextController.text,
                            _tempProfileImagePath);

                        bool response =
                            await confirmChanges(context, profileUpdateInfo);
                        if (response) Navigator.pop(context);
                      }),
                  TextButton(
                    title: "Cancel",
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            )
          ]),
    );
  }
}
