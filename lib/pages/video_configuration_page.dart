import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/shared/widgets/buttons/button_grid.dart';
import 'package:xbox_launcher/shared/widgets/buttons/check_button.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/pages/configurations_page/widgets/models/configuration_menu.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class VideoConfigurationPage extends ConfigurationMenu {
  const VideoConfigurationPage({Key? key})
      : super(
          "General",
          "Video",
          key: key,
        );

  @override
  List<ShortcutOption>? defineMapping(BuildContext context) => [
        ShortcutOption("Back",
            controllerKeyboardPair: ControllerKeyboardPair(
                const SingleActivator(LogicalKeyboardKey.escape),
                ControllerButton.B_BUTTON),
            action: () => Navigator.pop(context))
      ];

  @override
  List<ButtonGridGroup> buttonsBuilder(BuildContext context) {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    return [
      ButtonGridGroup(
        groupName: "Window",
        buttons: [
          CheckButton(
            title: "Fullscreen",
            checked: profileProvider.fullscreen,
            onChange: null,
            onPressed: () =>
                profileProvider.fullscreen = !profileProvider.fullscreen,
            color: profileProvider.accentColor,
          ),
        ],
      )
    ];
  }
}
