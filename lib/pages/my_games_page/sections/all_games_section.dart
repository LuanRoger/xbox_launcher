import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/xcloud_game_database_provider.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/game_button_tile.dart';
import 'package:xbox_launcher/shared/widgets/tile_grid.dart';

class AllGamesSection extends StatelessWidget {
  AllGamesSection({Key? key}) : super(key: key);

  List<GameButtonTile>? generateTilesFromProvider(BuildContext context) {
    List<GameButtonTile> gamesTile = List.empty(growable: true);
    Provider.of<XcloudGameDatabaseProvider>(context, listen: false)
        .xcloudGames
        ?.forEach((gameModel) {
      gamesTile.add(GameButtonTile(gameModel, tileSize: TileSize.MEDIUM));
    });

    return gamesTile.isNotEmpty ? gamesTile : null;
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<XcloudGameDatabaseProvider>(context, listen: false)
        .deserializeGames();

    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Flexible(
              child: Text(
                "Games",
                style: AppTextStyle.MY_GAMES_SECTIONS_TILE,
              )),
          const Spacer(),
          Expanded(
            flex: 7,
              child: TileGrid.count(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            tiles: generateTilesFromProvider(context)!,
            scrollDirection: Axis.vertical,
          )),
        ],
      ),
    );
  }
}
