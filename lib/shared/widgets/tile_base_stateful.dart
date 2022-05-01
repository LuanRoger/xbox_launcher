// ignore_for_file: no_logic_in_create_state

import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/tile_base.dart';

abstract class TileBaseStateful extends StatefulWidget implements TileBase {
  TileBaseStateful({Key? key}) : super(key: key);

  State<StatefulWidget> vitualCreateState();

  @override
  State<StatefulWidget> createState() => vitualCreateState();
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
