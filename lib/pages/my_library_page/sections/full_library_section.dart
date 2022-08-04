import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/system_app_controller.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/buttons/search_button.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_grid.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/widget_gen.dart';
import 'package:xbox_launcher/utils/loaders/xcloud_json_db_loader.dart';

class FullLibrarySection extends NavigationSection {
  late List<AppModel> library;
  TextEditingController searchController = TextEditingController();
  List<AppModel>? searchResult;

  void Function(void Function())? _reloadTilesGrid;

  FullLibrarySection({Key? key}) : super("Full library", key: key);

  Future<List<GameModel>?> _loadXCloudGames(BuildContext context) async {
    ProfileProvider profileProvider = context.read<ProfileProvider>();
    XCloudJsonDbLoader xcloudGamesLoader = XCloudJsonDbLoader();

    if (profileProvider.xcloudGamesJsonPath == null) return null;

    xcloudGamesLoader.jsonFilePath = profileProvider.xcloudGamesJsonPath!;
    await xcloudGamesLoader.readJsonFile();
    return xcloudGamesLoader.deserializeAllJson();
  }

  Future _createListFullLibrary(BuildContext context) async {
    library = List.empty(growable: true);

    //Add System apps
    library.addAll(SystemAppController.systemApps);

    //Add Xcloud games
    var games = await _loadXCloudGames(context);
    library.addAll(games ?? []);

    //Add External games
    library.addAll(
        Provider.of<ProfileProvider>(context, listen: false).externalGames);

    library.sort((first, second) => first.name.compareTo(second.name));
  }

  void searchGamesByName(String appName) {
    appName = appName.toLowerCase();

    List<AppModel> queryResult = library
        .where((game) => game.name.toLowerCase().contains(appName))
        .toList();

    if (queryResult.isEmpty) {
      _reloadTilesGrid!.call(() => searchResult = null);
      return;
    }

    _reloadTilesGrid!.call(() => searchResult = queryResult);
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        SearchButton(
          controller: searchController,
          onFinish: (cancel) {
            if (cancel) return;

            searchGamesByName(searchController.text);
          },
        ),
      ];

  @override
  List<Widget> buildColumnItems(BuildContext context) => [
        Expanded(
            flex: 10,
            child: StatefulBuilder(
              builder: (_, setState) {
                _reloadTilesGrid = setState;
                return FutureBuilder(
                  future: _createListFullLibrary(context),
                  builder: (_, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const ProgressRing();
                      default:
                        return TileGrid.count(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          tiles: WidgetGen.generateByModel(
                              searchResult ?? library,
                              TileGeneratorOption([TileSize.MEDIUM],
                                  context: context)),
                          scrollDirection: Axis.vertical,
                        );
                    }
                  },
                );
              },
            ))
      ];
}
