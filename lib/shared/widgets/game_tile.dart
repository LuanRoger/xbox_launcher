import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/game_model.dart';
import 'package:xbox_launcher/pages/game_page/game_page.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/tile_base.dart';

class GameTile extends TileBase {
  GameModel gameModel;
  TileSize tileSize;

  GameTile(this.gameModel, {Key? key, this.tileSize = TileSize.BIG})
      : super(gameModel.gameTitle, tileSize,
            image: gameModel.imageUrl != null
                ? NetworkImage(gameModel.imageUrl!)
                : null) {
    super.onPressed = (context) {
      Navigator.push(
          context,
          FluentPageRoute(
              builder: (context) =>
                  GamePage(gameModel.xcloudUrl, super.tileCover)));
    };
  }
}
