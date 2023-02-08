import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/shared/widgets/tiles/models/tile_widget.dart';
import 'package:xbox_launcher/shared/widgets/tiles/utils/tiles_generator.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';

class AppsTileRow extends StatelessWidget with TileGenerator {
  List<AppModel> tiles;
  final TileGeneratorOption customGenerateOption;

  AppsTileRow(
      {super.key, required this.tiles, required this.customGenerateOption});

  List<Widget> wrapInFlexibles(List<TileWidget> tiles) {
    List<Widget> spacedRow = List.empty(growable: true);

    for (TileWidget tile in tiles) {
      spacedRow.add(Flexible(flex: spacedRow.length > 1 ? 30 : 0, child: tile));
      spacedRow.add(const Spacer());
    }

    return spacedRow;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: wrapInFlexibles(generateByModel(tiles, customGenerateOption)),
    );
  }
}
