import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/tiles/utils/tiles_generator.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';

class AppsTilesGrid extends StatelessWidget with TileGenerator {
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
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: _crossAxisCount(customGenerationOption.tilesSize),
      crossAxisSpacing: crossAxisSpacing ?? 0.0,
      mainAxisSpacing: mainAxisSpacing ?? 0.0,
      shrinkWrap: true,
      scrollDirection: scrollDirection,
      children: generateByModel(apps, customGenerationOption),
    );
  }
}
