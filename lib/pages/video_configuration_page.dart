import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/keyboard_controller_action_manipulator.dart';
import 'package:xbox_launcher/shared/widgets/buttons/check_button.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/pages/configurations_page/widgets/configuration_menu.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_button.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class VideoConfigurationPage extends ConfigurationMenu {
  VideoConfigurationPage({Key? key})
      : super(
          "General",
          "Video",
          pageKeysAction: {
            ControllerKeyboardPair(
                    const SingleActivator(LogicalKeyboardKey.escape),
                    ControllerButton.B_BUTTON):
                ((context) => Navigator.pop(context))
          },
          key: key,
        );

  @override
  void defineMapping(BuildContext context) {
    KeyboardControllerActionManipulator.mapKeyboardControllerActions(
        context, pageKeysAction!);
  }

  @override
  Map<String, List<SystemButton>> buttonsBuilder(BuildContext context) {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    return {
      "Window": [
        CheckButton(
          title: "Fullscreen",
          checked: profileProvider.fullscreen,
          onChange: null,
          onPressed: () =>
              profileProvider.fullscreen = !profileProvider.fullscreen,
          color: profileProvider.accentColor,
        )
      ]
    };
  }
}