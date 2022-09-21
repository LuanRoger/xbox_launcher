import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/buttons/search_button.dart';
import 'package:xbox_launcher/shared/widgets/chip/chip_base.dart';
import 'package:xbox_launcher/shared/widgets/chip/chip_row.dart';
import 'package:xbox_launcher/shared/widgets/chip/text_chip.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section_stateful.dart';
import 'package:xbox_launcher/shared/widgets/placeholder_messages/xcloud_file_unavailable.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_grid.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/widget_gen.dart';
import 'package:xbox_launcher/utils/loaders/xcloud_json_db_loader.dart';

class MyGamesSection extends NavigationSectionStateful {
  const MyGamesSection({Key? key}) : super("Games", key: key);

  @override
  State<StatefulWidget> createState() => _MyGamesSectionState();
}

class _MyGamesSectionState extends NavigationSectionStatefulState {
  late XCloudJsonDbLoader gamesLoader;
  late List<GameModel> gamesList;
  List<GameModel>? gamesSearchResult;
  TextEditingController searchTextController = TextEditingController();
  List<ChipBase> chipsList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
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

  void searchGamesByName(String gameName) {
    gameName = gameName.toLowerCase();

    List<GameModel> searchResult = gamesList
        .where((game) => game.name.toLowerCase().contains(gameName))
        .toList();

    if (searchResult.isEmpty) {
      setState(() => gamesSearchResult = null);
      return;
    }

    setState(() => gamesSearchResult = searchResult);
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

  void updateChipsList() {
    List<String> gamesGenre = List.empty(growable: true);

    for (GameModel game in gamesList) {
      gamesGenre.addAll(game.gameGenres);
    }

    List<Widget> tempChipsList = List.empty(growable: true);
    for (String gameGenre in Set.from(gamesGenre)) {
      tempChipsList.add(TextChip(gameGenre));
    }

    chipsList = List.from(tempChipsList);
  }

  @override
  List<Widget> columnItems(BuildContext context) => [
        Expanded(
            flex: 10,
            child: FutureBuilder(
              future: readXCloudGames(context),
              builder: (_, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const ProgressRing();
                  default:
                    if (!snapshot.hasData &&
                        snapshot.data as bool &&
                        gamesList.isEmpty) const XCloudFileUnavailable();

                    updateChipsList();
                    return Column(
                      children: [
                        Expanded(
                            child: ChipsRow(
                          chipsList,
                          onCheckChange: (isSelected, value) {
                            print(value);
                          },
                        )),
                        const Spacer(),
                        Expanded(
                          flex: 10,
                          child: TileGrid.count(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            tiles: WidgetGen.generateByModel(
                                gamesSearchResult ?? gamesList,
                                TileGeneratorOption([TileSize.MEDIUM],
                                    context: context)),
                            scrollDirection: Axis.vertical,
                          ),
                        ),
                      ],
                    );
                }
              },
            )),
      ];
}
