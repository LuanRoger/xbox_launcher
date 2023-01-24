import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/external_file_picker.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/pages/configurations_page/widgets/models/configuration_menu.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/buttons/button_grid.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/menu_dialog_overlay.dart';
import 'package:xbox_launcher/shared/widgets/tiles/button_tile.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class PersonalizationConfigurationPage extends ConfigurationMenu {
  const PersonalizationConfigurationPage({Key? key})
      : super("General", "Personalization", key: key);

  @override
  List<ShortcutOption>? defineMapping(BuildContext context) => [
        ShortcutOption("Back",
            controllerKeyboardPair: ControllerKeyboardPair(
                const SingleActivator(LogicalKeyboardKey.escape),
                ControllerButton.B_BUTTON),
            action: () => Navigator.pop(context))
      ];

  void setCustomImage(BuildContext context) async {
    var profileProvider = context.read<ProfileProvider>();

    String? imagePath = await ExternalFilePicker.getImagePath();
    if (imagePath == null) return;

    profileProvider.imageBackgroundPath = imagePath;
    profileProvider.preferenceByImage = true;
  }

  void setMainColor(BuildContext context) {
    MenuDialogOverlay("Colors",
        content: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2),
          itemCount: AppColors.COLORS_LIST.length - 1,
          itemBuilder: (context, index) {
            return ButtonTile(
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
        content: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2),
          itemCount: AppColors.COLORS_LIST.length - 1,
          itemBuilder: (context, index) {
            return ButtonTile(
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
  List<ButtonGridGroup> buttonsBuilder(BuildContext context) => [
        ButtonGridGroup(
          groupName: "Colors",
          buttons: [
            TextButton(title: "Colors", onPressed: () => setMainColor(context)),
          ],
        ),
        ButtonGridGroup(
          groupName: "My Background",
          buttons: [
            TextButton(
                title: "Solid color",
                onPressed: () => setBackgroundColor(context)),
            TextButton(
                title: "Custom image",
                onPressed: () => setCustomImage(context)),
            TextButton(
                title: "Reset background",
                onPressed: () =>
                    Provider.of<ProfileProvider>(context, listen: false)
                        .resetBackground()),
          ],
        )
      ];
}
