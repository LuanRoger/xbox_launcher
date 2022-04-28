import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/pages/configurations_page/widgets/configuration_menu.dart';
import 'package:xbox_launcher/shared/widgets/check_tile_grid.dart';
import 'package:xbox_launcher/shared/widgets/menu_dialog_overlay.dart';
import 'package:xbox_launcher/shared/widgets/system_button.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class PersonalizationConfigurationPage extends ConfigurationMenu {
  PersonalizationConfigurationPage(BuildContext context, {Key? key})
      : super("General", "Personalization",
            keyAction: {
              ControllerKeyboardPair(
                      LogicalKeyboardKey.escape, ControllerButton.BACK):
                  ((context) => Navigator.pop(context))
            },
            buttons: {
              "Colorization": [
                SystemButton(
                  "Colors",
                  width: 170,
                  height: 70,
                  onPressed: () => MenuDialogOverlay("Colors",
                      actions: [
                        SystemButton(
                          "Save",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          width: 170,
                          height: 70,
                        )
                      ],
                      content: CheckTile(
                        width: 100,
                        height: 100,
                        child: Container(color: Colors.red),
                      )).show(context),
                )
              ]
            },
            key: key);
}
