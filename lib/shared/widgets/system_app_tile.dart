import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/button_tile.dart';

class SystemAppButtonTile extends ButtonTile {
  SystemAppButtonTile(String appName, IconData iconData,
      {Key? key,
      required TileSize tileSize,
      required void Function(BuildContext) onClick})
      : super(appName, true,
            key: key, tileSize: tileSize, icon: iconData, onPressed: onClick);
}
