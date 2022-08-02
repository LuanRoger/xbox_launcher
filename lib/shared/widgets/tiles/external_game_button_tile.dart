import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/app_models/external_game_model.dart';
import 'package:xbox_launcher/pages/external_game_page.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/routes/app_routes.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/tiles/button_tile.dart';

class ExternalGameButtonTile extends ButtonTile {
  ExternalGameModel gameModel;

  ExternalGameButtonTile(this.gameModel, {required TileSize tileSize})
      : super(
          gameModel.name,
          true,
          tileSize: tileSize,
          image: gameModel.imagePath != null
              ? FileImage(File(gameModel.imagePath!))
              : null,
          onPressed: (context) {
            Navigator.pushNamed(context, AppRoutes.externalGameRoute,
                arguments: [gameModel]);
            Provider.of<ProfileProvider>(context, listen: false)
                .addAppToHistory(gameModel);
          },
        );
}
