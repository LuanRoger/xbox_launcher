import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/external_file_picker.dart';
import 'package:xbox_launcher/controllers/keyboard_controller_action_manipulator.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/pages/configurations_page/widgets/configuration_menu.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart'
    as xbox_button;
import 'package:xbox_launcher/shared/widgets/tile_grid.dart';
import 'package:xbox_launcher/shared/widgets/menu_dialog_overlay.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_button.dart';
import 'package:xbox_launcher/shared/widgets/button_tile.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class PersonalizationConfigurationPage extends ConfigurationMenu {
  PersonalizationConfigurationPage({Key? key})
      : super("General", "Personalization",
            pageKeysAction: {
              ControllerKeyboardPair(
                      LogicalKeyboardKey.escape, ControllerButton.B_BUTTON):
                  ((context) => Navigator.pop(context))
            },
            key: key);

  @override
  void defineMapping(BuildContext context) {
    KeyboardControllerActionManipulator.mapKeyboardControllerActions(
        context, pageKeysAction!);
  }

  void setCustomImage(BuildContext context) async {
    var profileProvider = context.read<ProfileProvider>();

    String? imagePath = await ExternalFilePicker.getImagePath();
    if (imagePath == null) return;

    profileProvider.imageBackgroundPath = imagePath;
    profileProvider.preferenceByImage = true;
  }

  void setMainColor(BuildContext context) {
    MenuDialogOverlay("Colors",
        content: TileGrid.build(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2),
          itemCount: AppColors.COLORS_LIST.length - 1,
          itemBuilder: (context, index) {
            return ButtonTile(
              "",
              false,
              tileSize: TileSize.MEDIUM,
              color: AppColors.COLORS_LIST[index],
              onPressed: (context) {
                Provider.of<ProfileProvider>(context, listen: false)
                    .preferedColorIndex = index;
                Navigator.pop(context);
              },
            );
          },
          scrollDirection: Axis.horizontal,
        )).show(context);
  }

  void setBackgroundColor(BuildContext context) {
    MenuDialogOverlay("Background color",
        content: TileGrid.build(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2),
          itemCount: AppColors.COLORS_LIST.length - 1,
          itemBuilder: (context, index) {
            return ButtonTile(
              "",
              false,
              tileSize: TileSize.MEDIUM,
              color: AppColors.COLORS_LIST[index],
              onPressed: (context) {
                var state = context.read<ProfileProvider>();
                state.backgroundColorIndex = index;
                state.preferenceByImage = false;

                Navigator.pop(context);
              },
            );
          },
          scrollDirection: Axis.horizontal,
        )).show(context);
  }

  @override
  Map<String, List<SystemButton>> buttonsBuilder(BuildContext context) => {
        "Colors": [
          xbox_button.TextButton(
              title: "Colors", onPressed: () => setMainColor(context)),
        ],
        "My Background": [
          xbox_button.TextButton(
              title: "Solid color",
              onPressed: () => setBackgroundColor(context)),
          xbox_button.TextButton(
              title: "Custom image", onPressed: () => setCustomImage(context)),
          xbox_button.TextButton(
              title: "Reset background",
              onPressed: () =>
                  Provider.of<ProfileProvider>(context, listen: false)
                      .resetBackground())
        ]
      };
}
