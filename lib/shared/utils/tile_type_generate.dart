import 'package:flutter/cupertino.dart';
import 'package:xbox_launcher/models/app_model.dart';
import 'package:xbox_launcher/models/game_model.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/utils/models/tile_generator_option.dart';
import 'package:xbox_launcher/shared/widgets/game_button_tile.dart';
import 'package:xbox_launcher/shared/widgets/system_app_tile.dart';
import 'package:xbox_launcher/shared/widgets/tile_base.dart';

class TileTypeGenerate {
  static List<TileBase> generateByModel(
      List<AppModel> appModels, TileGeneratorOption option) {
    List<TileBase> tiles = List.empty(growable: true);

    for (AppModel model in appModels) {
      TileBase tile;
      switch (model.appType) {
        case AppType.GAME:
          tile = GameButtonTile(model as GameModel,
              tileSize: tiles.length >= option.sizes.length
                  ? option.sizes.last
                  : option.sizes[tiles.length]);
          break;
        default:
          throw UnimplementedError("External Apps not implemented yet");
      }
      tiles.add(tile);
    }

    return tiles;
  }
}
