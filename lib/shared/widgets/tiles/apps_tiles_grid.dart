import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/models/app_models/system_app_model.dart';
import 'package:xbox_launcher/models/profile_preview_elements_preferences.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/hooks/element_focus_node_hook.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_node.dart';
import 'package:xbox_launcher/shared/widgets/tiles/game_button_tile.dart';
import 'package:xbox_launcher/shared/widgets/tiles/models/tile_generator.dart';
import 'package:xbox_launcher/shared/widgets/tiles/models/tile_widget.dart';
import 'package:xbox_launcher/shared/widgets/tiles/system_app_tile.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';

class AppsTilesGrid extends HookWidget implements TileGenerator {
  final List<AppModel> apps;
  final Axis scrollDirection;
  final TileGeneratorOption customGenerationOption;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;

  const AppsTilesGrid(
      {super.key,
      required this.apps,
      this.crossAxisSpacing,
      this.mainAxisSpacing,
      this.scrollDirection = Axis.vertical,
      required this.customGenerationOption});

  int _crossAxisCount(TileSize tileSize) {
    switch (tileSize) {
      case TileSize.SMALL:
        return 8;
      case TileSize.BIG:
        return 4;
      case TileSize.LENGHTY:
      case TileSize.MEDIUM:
      default:
        return 6;
    }
  }

  @override
  List<TileWidget> generateByModel(List<AppModel> appModels, TileSize tilesSize,
      TileGeneratorOption option) {
    List<TileWidget> tiles = List.empty(growable: true);

    for (AppModel model in appModels) {
      TileWidget tile;
      ElementFocusNode? focusNode = option.focusScope != null
          ? useElementFocusNode(option.focusScope!)
          : null;

      switch (model.appType) {
        case AppType.GAME:
          tile = GameButtonTile(
            model as GameModel,
            tileSize: tilesSize,
            focusNode: focusNode,
          );
          break;
        case AppType.SYSTEM_APP:
          tile = SystemAppButtonTile(
            model as SystemAppModel,
            tileSize: tilesSize,
            context: option.context,
            focusNode: focusNode,
          );
          break;
        default:
          throw UnimplementedError(
              model.runtimeType.toString() + " not implemented yet.");
      }
      tiles.add(tile);
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (_, value, __) => GridView.count(
        crossAxisCount: _crossAxisCount(value.myLibraryTileSize),
        crossAxisSpacing: crossAxisSpacing ?? 0.0,
        mainAxisSpacing: mainAxisSpacing ?? 0.0,
        shrinkWrap: true,
        scrollDirection: scrollDirection,
        children: generateByModel(
            apps, value.myLibraryTileSize, customGenerationOption),
      ),
    );
  }
}
