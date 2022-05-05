import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/button_tile.dart';

class AppTile extends ButtonTile {
  AppTile(String title,
      {Key? key,
      required IconData icon,
      required TileSize tileSize,
      required void Function(BuildContext)? onClick})
      : super(title, true,
            tileSize: tileSize, key: key, icon: icon, onPressed: onClick);
}
