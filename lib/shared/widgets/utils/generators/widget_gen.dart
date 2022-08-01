import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/models/app_models/external_game_model.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/models/app_models/system_app_model.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/tiles/external_game_button_tile.dart';
import 'package:xbox_launcher/shared/widgets/tiles/game_button_tile.dart';
import 'package:xbox_launcher/shared/widgets/tiles/system_app_tile.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_base.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';

class WidgetGen {
  static Widget generateTileCover(
      {required Color colorByGenerator,
      Color? color,
      ImageProvider? image,
      IconData? icon}) {
    Widget _tileCover;
    if (image != null) {
      _tileCover = Image(
        image: image,
        fit: BoxFit.cover,
      );
    } else if (icon != null) {
      _tileCover = Container(
        color: color ?? colorByGenerator,
        child: Align(
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: Colors.white,
            size: 35,
          ),
        ),
      );
    } else {
      _tileCover = Container(color: color ?? colorByGenerator);
    }

    return _tileCover;
  }

  static List<TileBase> generateByModel(
      List<AppModel> appModels, TileGeneratorOption option) {
    List<TileBase> tiles = List.empty(growable: true);

    for (AppModel model in appModels) {
      TileBase tile;
      TileSize actualTileSize = tiles.length >= option.sizes.length
          ? option.sizes.last
          : option.sizes[tiles.length];

      switch (model.appType) {
        case AppType.GAME:
          tile = GameButtonTile(model as GameModel, tileSize: actualTileSize);
          break;
        case AppType.SYSTEM_APP:
          tile = SystemAppButtonTile(
            model as SystemAppModel,
            tileSize: actualTileSize,
            context: option.context,
          );
          break;
        case AppType.EXTERNAL_APP:
          tile = ExternalGameButtonTile(model as ExternalGameModel,
              tileSize: actualTileSize);
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
