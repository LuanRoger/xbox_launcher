import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_models/system_app_model.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/commands/models/command_invoker.dart';
import 'package:xbox_launcher/shared/widgets/commands/open_app_command.dart';
import 'package:xbox_launcher/shared/widgets/tiles/button_tile.dart';

class SystemAppButtonTile extends ButtonTile {
  SystemAppModel appModel;

  SystemAppButtonTile(this.appModel,
      {Key? key,
      required BuildContext context, //Context to navigate
      required TileSize tileSize})
      : super(appModel.name,
            interactive: true,
            key: key,
            tileSize: tileSize,
            icon: appModel.icon, onPressed: (_) {
          CommandInvoker command = CommandInvoker(
              OpenAppCommand(appModel, context: context));
          command.execute();
        });
}
