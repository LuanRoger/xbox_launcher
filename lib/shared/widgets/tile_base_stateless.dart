import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/tile_base.dart';

abstract class TileBaseStateless extends StatelessWidget implements TileBase {
  Widget virtualBuild();

  TileBaseStateless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: width,
      height: height,
      child: virtualBuild(),
    );
  }
}
