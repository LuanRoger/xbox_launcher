import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/app_models/external_game_model.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section.dart';
import 'package:xbox_launcher/shared/widgets/tile_grid.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/widget_gen.dart';

class MyExternalGamesSection extends NavigationSection {
  late List<ExternalGameModel> _externalGamesList;
  List<ExternalGameModel>? _searchResult;

  void Function(void Function())? _reloadTileGrid;

  MyExternalGamesSection({Key? key}) : super("External games", key: key);

  void searchGamesByName(String gameName) {
    List<ExternalGameModel> searchResult = _externalGamesList
        .where((game) => game.name.toLowerCase().contains(gameName))
        .toList();

    if (searchResult.isEmpty) {
      _reloadTileGrid!.call(() => _searchResult = null);
      return;
    }

    _reloadTileGrid!.call(() => _searchResult = searchResult);
  }

  @override
  List<Widget>? buildActions(BuildContext context) => null;

  @override
  List<Widget> buildColumnItems(BuildContext context) {
    _externalGamesList = context.read<ProfileProvider>().externalGames;

    return [
      Expanded(
          flex: 10,
          child: StatefulBuilder(builder: ((_, setState) {
            _reloadTileGrid = setState;

            return TileGrid.count(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              tiles: WidgetGen.generateByModel(
                  _searchResult ?? _externalGamesList,
                  TileGeneratorOption([TileSize.BIG], context: context)),
            );
          })))
    ];
  }
}
