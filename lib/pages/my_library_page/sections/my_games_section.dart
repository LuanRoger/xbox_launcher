import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/buttons/search_button.dart';
import 'package:xbox_launcher/shared/widgets/game_button_tile.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section.dart';
import 'package:xbox_launcher/shared/widgets/placeholder_messages/xcloud_file_unavailable.dart';
import 'package:xbox_launcher/shared/widgets/tile_grid.dart';
import 'package:xbox_launcher/utils/loaders/xcloud_json_db_loader.dart';

class MyGamesSection extends NavigationSection {
  late XCloudJsonDbLoader gamesLoader;
  late List<GameModel> gamesList;
  List<GameModel>? gamesSearchResult;
  TextEditingController searchTextController = TextEditingController();

  void Function(void Function())? _reloadTilesGrid;

  MyGamesSection({Key? key}) : super("Games", key: key) {
    gamesLoader = XCloudJsonDbLoader();
  }

  Future<bool> readXCloudGames(BuildContext context) async {
    ProfileProvider profileProvider = context.read<ProfileProvider>();
    if (profileProvider.xcloudGamesJsonPath == null) return false;

    gamesLoader.jsonFilePath = profileProvider.xcloudGamesJsonPath!;
    await gamesLoader.readJsonFile();
    gamesList = gamesLoader.deserializeAllJson();
    return true;
  }

  //TODO: Move to generator class
  List<GameButtonTile> generateTilesFromList(List<GameModel> gamesList) {
    List<GameButtonTile> gamesTile = List.empty(growable: true);
    for (var gameModel in gamesList) {
      gamesTile.add(GameButtonTile(gameModel, tileSize: TileSize.MEDIUM));
    }

    return gamesTile;
  }

  void searchGamesByName(String gameName) {
    List<GameModel> searchResult = gamesList
        .where((game) => game.name.toLowerCase().contains(gameName))
        .toList();

    if (searchResult.isEmpty) {
      _reloadTilesGrid!.call(() => gamesSearchResult = null);
      return;
    }

    _reloadTilesGrid!.call(() => gamesSearchResult = searchResult);
  }
  
  @override
  List<Widget>? buildActions(BuildContext context) => [
        SearchButton(
          controller: searchTextController,
          width: 100.0,
          height: 30.0,
          onFinish: (cancel) {
            if (cancel) return;

            searchGamesByName(searchTextController.text);
          },
        ),
      ];

  @override
  List<Widget> buildColumnItems(BuildContext context) => [
        Expanded(
          flex: 10,
          child: StatefulBuilder(
            builder: (_, setState) {
              _reloadTilesGrid ??= setState;
              return FutureBuilder(
                future: readXCloudGames(context),
                builder: (_, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const ProgressRing();
                    default:
                      return snapshot.hasData &&
                              snapshot.data as bool &&
                              gamesList.isNotEmpty
                          ? TileGrid.count(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              tiles: generateTilesFromList(
                                  gamesSearchResult ?? gamesList),
                              scrollDirection: Axis.vertical,
                            )
                          : const XCloudFileUnavailable();
                  }
                },
              );
            },
          ),
        ),
      ];
}
