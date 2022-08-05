import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_models/external_game_model.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/commands/models/command_invoker.dart';
import 'package:xbox_launcher/shared/widgets/commands/open_app_command.dart';
import 'package:xbox_launcher/shared/widgets/external_game_icon.dart';
import 'package:xbox_launcher/shared/widgets/tiles/button_tile.dart';

class ExternalGameButtonTile extends ButtonTile {
  ExternalGameModel gameModel;

  ExternalGameButtonTile(this.gameModel, {Key? key, required TileSize tileSize})
      : super(
          gameModel.name,
          key: key,
          interactive: true,
          tileSize: tileSize,
          image: gameModel.imagePath != null
              ? FileImage(File(gameModel.imagePath!))
              : null,
          customCover: gameModel.iconUrl != null
              ? ExternalGameIcon(iconUrl: gameModel.iconUrl)
              : null,
          onPressed: (context) {
            CommandInvoker command =
                CommandInvoker(OpenAppCommand(gameModel, context: context));
            command.execute();
          },
        );
}
