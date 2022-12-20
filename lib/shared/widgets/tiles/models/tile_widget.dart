import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';

abstract class TileWidget extends StatefulWidget {
  void Function(BuildContext)? onPressed;
  late double width;
  late double height;
  TileSize tileSize;
  Color? color;

  TileWidget(
      {super.key,
      required this.tileSize,
      required this.color,
      this.onPressed}) {
    switch (tileSize) {
      case TileSize.SMALL:
        width = 100;
        height = 100;
        break;
      case TileSize.MEDIUM:
        width = 150;
        height = 150;
        break;
      case TileSize.BIG:
        width = 300;
        height = 300;
        break;
      case TileSize.LENGHTY:
        width = 200;
        height = 100;
        break;
    }
  }

  @override
  State<TileWidget> createState();
}

abstract class TileWidgetState<T extends TileWidget> extends State<T> {
  Widget virtualBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      width: widget.width,
      height: widget.height,
      child: virtualBuild(context),
    );
  }
}
