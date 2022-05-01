import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/pages/configurations_page/widgets/configuration_menu.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/tile_grid.dart';
import 'package:xbox_launcher/shared/widgets/menu_dialog_overlay.dart';
import 'package:xbox_launcher/shared/widgets/tile_base.dart';
import 'package:xbox_launcher/shared/widgets/system_button.dart';
import 'package:xbox_launcher/shared/widgets/button_tile.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class PersonalizationConfigurationPage extends ConfigurationMenu {
  int? newColor;

  PersonalizationConfigurationPage(BuildContext context, {Key? key})
      : super("General", "Personalization",
            keyAction: {
              ControllerKeyboardPair(
                      LogicalKeyboardKey.escape, ControllerButton.BACK):
                  ((context) => Navigator.pop(context))
            },
            key: key);

  @override
  Map<String?, List<SystemButton>> buttonsBuilder(BuildContext context) {
    return {
      null: [
        SystemButton(
          "Colors",
          width: 170,
          height: 70,
          onPressed: () => MenuDialogOverlay("Colors",
              content: TileGrid.build(
                  itemCount: AppColors.COLORS_LIST.length - 1,
                  itemBuilder: (context, index) {
                    return ButtonTile(
                      "Color",
                      false,
                      tileSize: TileSize.MEDIUM,
                      color: AppColors.COLORS_LIST[index],
                      onPressed: (context) {
                        Navigator.pop(context);
                      },
                    );
                  })).show(context),
        )
      ]
    };
  }
}
