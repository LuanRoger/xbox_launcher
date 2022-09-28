import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/shortcut_activator.dart';
import 'package:xbox_launcher/shared/widgets/buttons/check_button.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/pages/page_models_base/configuration_menu.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_button.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class VideoConfigurationPage extends ConfigurationMenu {
  VideoConfigurationPage({Key? key})
      : super(
          "General",
          "Video",
          key: key,
        );

  @override
  List<ShortcutOption>? defineMapping(BuildContext context) => [
        ShortcutOption("",
            controllerKeyboardPair: ControllerKeyboardPair(
                const SingleActivator(LogicalKeyboardKey.escape),
                ControllerButton.B_BUTTON),
            action: (context) => Navigator.pop(context))
      ];

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
