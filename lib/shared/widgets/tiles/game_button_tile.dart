import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/pages/game_page.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/routes/app_routes.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/tiles/button_tile.dart';

class GameButtonTile extends ButtonTile {
  GameModel gameModel;

  GameButtonTile(this.gameModel, {Key? key, required TileSize tileSize})
      : super(
          gameModel.name,
          true,
          key: key,
          tileSize: tileSize,
          image: NetworkImage(gameModel.tileGameImageUrl),
          onPressed: (context) {
            Navigator.pushNamed(context, AppRoutes.xcloudGameRoute, arguments: [
              gameModel,
              context.read<ProfileProvider>().preferedServer
            ]);
            Provider.of<ProfileProvider>(context, listen: false)
                .addAppToHistory(gameModel);
          },
        );
}
