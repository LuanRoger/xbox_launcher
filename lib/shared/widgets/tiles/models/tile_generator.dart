import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/models/app_models/system_app_model.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/hooks/element_focus_node_hook.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_node.dart';
import 'package:xbox_launcher/shared/widgets/tiles/game_button_tile.dart';
import 'package:xbox_launcher/shared/widgets/tiles/models/tile_widget.dart';
import 'package:xbox_launcher/shared/widgets/tiles/system_app_tile.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';

abstract class TileGenerator {
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
}
