// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/buttons/search_button.dart';
import 'package:xbox_launcher/shared/widgets/chip/chip_base.dart';
import 'package:xbox_launcher/shared/widgets/chip/chip_row.dart';
import 'package:xbox_launcher/shared/widgets/chip/text_chip.dart';
import 'package:xbox_launcher/shared/widgets/combobox/combobox.dart';
import 'package:xbox_launcher/shared/enums/sort_options.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section_stateless.dart';
import 'package:xbox_launcher/shared/widgets/placeholder_messages/xcloud_file_unavailable_message.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_grid.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/widget_gen.dart';
import 'package:xbox_launcher/utils/loaders/xcloud_json_db_loader.dart';

class MyGamesSection extends NavigationSectionStateless {
  XCloudJsonDbLoader gamesLoader = XCloudJsonDbLoader();
  late List<GameModel> gamesList;
  void Function(void Function())? _reloadTileGrid;

  List<GameModel>? gamesSearchResult;
  String? gameGenreFilter;
  SortOptions? currentSortOption;

  //Cached lists
  List<GameModel>? _cachedReleaseDataGameSort;

  TextEditingController searchTextController = TextEditingController();
  late ChipsRow chipsRow;
  List<ChipBase>? chipsList;

  MyGamesSection({Key? key}) : super("Games", key: key);

  Future<bool> readXCloudGames(BuildContext context) async {
    ProfileProvider profileProvider = context.read<ProfileProvider>();
    if (profileProvider.xcloudGamesJsonPath == null) return false;

    gamesLoader.jsonFilePath = profileProvider.xcloudGamesJsonPath!;
    await gamesLoader.readJsonFile();
    gamesList = gamesLoader.deserializeAllJson();
    updateChipsList();
    return true;
  }

  void searchGamesByName(String gameName) {
    gameName = gameName.toLowerCase();

    List<GameModel> searchResult = gamesList
        .where((game) => game.name.toLowerCase().contains(gameName))
        .toList();

    if (searchResult.isEmpty) {
      _reloadTileGrid?.call(() => gamesSearchResult = null);
      return;
    }

    _reloadTileGrid?.call(() => gamesSearchResult = searchResult);
  }

  void filterByGenre(String? genre) {
    if (genre == null) {
      _reloadTileGrid?.call(() => gamesSearchResult = null);
      return;
    }

    List<GameModel> filterResult =
        gamesList.where((game) => game.gameGenres.contains(genre)).toList();

    if (filterResult.isEmpty) return;

    _reloadTileGrid?.call(() => gamesSearchResult = filterResult);
  }

  void updateChipsList() {
    List<String> gamesGenre = List.empty(growable: true);

    for (GameModel game in gamesList) {
      gamesGenre.addAll(game.gameGenres);
    }

    List<ChipBase> tempChipsList = List.empty(growable: true);
    for (String gameGenre in Set.from(gamesGenre)) {
      tempChipsList.add(TextChip(gameGenre));
    }

    chipsList = tempChipsList.toList();
  }

  void sortGameList(SortOptions? sortOptions) {
    if (sortOptions == null) return;

    switch (sortOptions) {
      case SortOptions.ATOZ:
        gamesList.sort((game1, game2) => game1.name.compareTo(game2.name));
        break;
      case SortOptions.RELEASE_DATE:
        if (_cachedReleaseDataGameSort != null) {
          gamesList = _cachedReleaseDataGameSort!;
        }
        gamesList.sort((game1, game2) {
          List<String> releaseDate1 = game1.releaseDate.split('/');
          DateTime game1ReleaseDate = DateTime.utc(int.parse(releaseDate1[2]),
              int.parse(releaseDate1[1]), int.parse(releaseDate1[0]));

          List<String> releaseDate2 = game1.releaseDate.split('/');
          DateTime game2ReleaseDate = DateTime.utc(int.parse(releaseDate2[2]),
              int.parse(releaseDate2[1]), int.parse(releaseDate2[0]));

          return game2ReleaseDate.compareTo(game1ReleaseDate);
        });
        _cachedReleaseDataGameSort = List.from(gamesList);
        break;
    }

    _reloadTileGrid?.call(() => currentSortOption = sortOptions);
  }

  @override
  List<Widget>? titleActions(BuildContext context) => [
        SearchButton(
          controller: searchTextController,
          onFinish: (cancel) {
            if (cancel) return;

            searchGamesByName(searchTextController.text);
          },
        ),
      ];

  @override
  List<Widget> columnItems(BuildContext context) {
    final TileSize tileSize = context.read<ProfileProvider>().myLibraryTileSize;

    return [
      Expanded(
          flex: 10,
          child: FutureBuilder(
            future: readXCloudGames(context),
            builder: (_, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const ProgressRing();
                default:
                  if (snapshot.hasData && !(snapshot.data as bool) ||
                      gamesList.isEmpty)
                    return const XCloudFileUnavailableMessage();

                  return Column(
                    children: [
                      Flexible(
                          child: ChipsRow(
                        chipsList ?? List.empty(),
                        onCheckChange: (isSelected, value) {
                          if (!isSelected) filterByGenre(null);

                          filterByGenre(value as String);
                        },
                      )),
                      const Spacer(),
                      Expanded(
                        flex: 13,
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            _reloadTileGrid = setState;
                            return Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ComboBox(
                                        [
                                          ComboboxItem(
                                            child: const Text("Sort: A to Z"),
                                            value: SortOptions.ATOZ.index,
                                          ),
                                          ComboboxItem(
                                            child: const Text("Release date"),
                                            value:
                                                SortOptions.RELEASE_DATE.index,
                                          )
                                        ],
                                        onChange: (sortOptionsIndex) =>
                                            sortGameList(SortOptions
                                                .values[sortOptionsIndex]),
                                        width: 270.0,
                                        height: double.infinity,
                                      )
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Expanded(
                                  flex: 20,
                                  child: TileGrid.tileSize(
                                    tileSize: tileSize,
                                    tiles: WidgetGen.generateByModel(
                                        gamesSearchResult ?? gamesList,
                                        TileGeneratorOption([tileSize],
                                            context: context)),
                                    scrollDirection: Axis.vertical,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
              }
            },
          )),
    ];
  }
}
