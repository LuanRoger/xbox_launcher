import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_models/system_app_model.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_node.dart';
import 'package:xbox_launcher/shared/widgets/tiles/button_tile_interactive.dart';
import 'package:xbox_launcher/shared/widgets/utils/commands/models/command_invoker.dart';
import 'package:xbox_launcher/shared/widgets/utils/commands/open_app_command.dart';

class SystemAppButtonTile extends ButtonTileInteractive {
  final SystemAppModel appModel;

  SystemAppButtonTile(this.appModel,
      {Key? key,
      required BuildContext context, //Context to navigate
      required TileSize tileSize,
      ElementFocusNode? focusNode})
      : super(appModel.name,
            key: key,
            tileSize: tileSize,
            elementValue: appModel,
            focusNode: focusNode,
            icon: appModel.icon, onPressed: (context, ref) {
          CommandInvoker command = CommandInvoker(
              OpenAppCommand(appModel, context: context, ref: ref));
          command.execute();
        });
}
