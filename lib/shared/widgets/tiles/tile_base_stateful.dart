import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_base.dart';

abstract class TileBaseStateful extends StatefulWidget implements TileBase {
  final Object? objectInfoSender;

  const TileBaseStateful({Key? key, this.objectInfoSender}) : super(key: key);
}

abstract class TileBaseStatefulState<T extends TileBaseStateful>
    extends State<T> {
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
