import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/game_model.dart';
import 'package:xbox_launcher/pages/game_page.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/button_tile.dart';

class GameButtonTile extends ButtonTile {
  GameModel gameModel;

  GameButtonTile(this.gameModel, {required TileSize tileSize})
      : super(
          gameModel.gameTitle,
          true,
          tileSize: tileSize,
          image: NetworkImage(gameModel.tileImageUrl),
          onPressed: (context) {
            Navigator.push(
              context,
              FluentPageRoute(
                builder: (context) => GamePage(
                    gameModel.xcloudUrl, NetworkImage(gameModel.gameImageUrl)),
              ),
            );
          },
        );
}
