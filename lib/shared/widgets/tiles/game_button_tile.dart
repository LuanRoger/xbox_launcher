import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_node.dart';
import 'package:xbox_launcher/shared/widgets/utils/commands/models/command_invoker.dart';
import 'package:xbox_launcher/shared/widgets/utils/commands/open_app_command.dart';
import 'package:xbox_launcher/shared/widgets/tiles/button_tile.dart';

class GameButtonTile extends ButtonTile {
  final GameModel gameModel;

  GameButtonTile(this.gameModel,
      {Key? key, required TileSize tileSize, ElementFocusNode? focusNode})
      : super(
          gameModel.name,
          key: key,
          elementValue: gameModel,
          interactive: true,
          appBadgeInfo: gameModel.extraGameProperties.toBadgeInfo(),
          tileSize: tileSize,
          image: NetworkImage(gameModel.tileGameImageUrl),
          focusNode: focusNode,
          onPressed: (context) {
            CommandInvoker command =
                CommandInvoker(OpenAppCommand(gameModel, context: context));
            command.execute();
          },
        );
}
