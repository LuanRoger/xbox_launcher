import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_base.dart';

class TileGrid extends StatelessWidget {
  late int? selectedTile;
  TileBase Function(BuildContext, int)? itemBuilder;
  List<TileBase>? tiles;
  int? itemCount;
  Axis scrollDirection;
  SliverGridDelegate gridDelegate;

  TileGrid(
      {Key? key,
      required this.gridDelegate,
      this.itemBuilder,
      this.tiles,
      this.itemCount,
      this.scrollDirection = Axis.vertical})
      : super(key: key);

  factory TileGrid.build(
      {Key? key,
      required TileBase Function(BuildContext, int)? itemBuilder,
      required int itemCount,
      required SliverGridDelegate gridDelegate,
      Axis scrollDirection = Axis.vertical}) {
    return TileGrid(
      gridDelegate: gridDelegate,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      scrollDirection: scrollDirection,
    );
  }

  factory TileGrid.count(
      {Key? key,
      required List<TileBase> tiles,
      required SliverGridDelegate gridDelegate,
      Axis scrollDirection = Axis.vertical}) {
    return TileGrid(
      tiles: tiles,
      gridDelegate: gridDelegate,
      itemCount: tiles.length,
      scrollDirection: scrollDirection,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: gridDelegate,
      shrinkWrap: true,
      scrollDirection: scrollDirection,
      itemBuilder: itemBuilder ??
          (context, index) {
            return tiles![index];
          },
      itemCount: itemCount,
    );
  }
}
