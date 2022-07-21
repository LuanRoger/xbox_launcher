import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/game_button_tile.dart';
import 'package:xbox_launcher/shared/widgets/placeholder_messages/xcloud_file_unavailable.dart';
import 'package:xbox_launcher/shared/widgets/tile_grid.dart';
import 'package:xbox_launcher/utils/loaders/xcloud_json_db_loader.dart';

class MyGamesSection extends StatelessWidget {
  late XCloudJsonDbLoader gamesLoader;

  MyGamesSection({Key? key}) : super(key: key) {
    gamesLoader = XCloudJsonDbLoader();
  }

  Future<bool> readXCloudGames(BuildContext context) async {
    ProfileProvider profileProvider = context.read<ProfileProvider>();
    if (profileProvider.xcloudGamesJsonPath == null) return false;

    gamesLoader.jsonFilePath = profileProvider.xcloudGamesJsonPath!;
    await gamesLoader.readJsonFile();
    return true;
  }

  List<GameButtonTile> generateTilesFromProvider(List<GameModel> gamesList) {
    List<GameButtonTile> gamesTile = List.empty(growable: true);
    for (var gameModel in gamesList) {
      gamesTile.add(GameButtonTile(gameModel, tileSize: TileSize.MEDIUM));
    }

    return gamesTile;
  }

  @override
  Widget build(BuildContext context) {
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
          FutureBuilder<bool>(
              future: readXCloudGames(context),
              builder: (_, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const ProgressRing();
                  default:
                    return Expanded(
                        flex: 7,
                        child: snapshot.hasData && snapshot.data!
                            ? TileGrid.count(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                tiles: generateTilesFromProvider(
                                    gamesLoader.deserializeAllJson()),
                                scrollDirection: Axis.vertical,
                              )
                            : const XCloudFileUnavailable());
                }
              }),
        ],
      ),
    );
  }
}
