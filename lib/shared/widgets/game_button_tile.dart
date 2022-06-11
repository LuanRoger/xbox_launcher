import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/apps_historic.dart';
import 'package:xbox_launcher/models/game_model.dart';
import 'package:xbox_launcher/pages/game_page.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/button_tile.dart';

class GameButtonTile extends ButtonTile {
  GameModel gameModel;

  GameButtonTile(this.gameModel, {Key? key, required TileSize tileSize})
      : super(
          gameModel.name!,
          true,
          key: key,
          tileSize: tileSize,
          image: NetworkImage(gameModel.tileGameImageUrl),
          onPressed: (context) {
            Navigator.push(
              context,
              FluentPageRoute(
                builder: (context) => GamePage(
                    gameModel.xcloudUrl, NetworkImage(gameModel.gameImageUrl)),
              ),
            );
            Provider.of<ProfileProvider>(context, listen: false)
                .addApp(gameModel);
          },
        );
}
