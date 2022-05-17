import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/tile_base.dart';

class TileRow extends StatelessWidget {
  List<TileBase> tiles;

  TileRow({Key? key, required this.tiles}) : super(key: key);

  List<Widget> _generateRow() {
    List<Widget> spacedRow = List.empty(growable: true);

    for (TileBase tile in tiles) {
      spacedRow.add(Flexible(flex: spacedRow.length > 1 ? 30 : 0, child: tile));
      spacedRow.add(const Spacer());
    }

    return spacedRow;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: _generateRow(),
    );
  }
}
