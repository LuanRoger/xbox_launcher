import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/tile_base.dart';

class SystemTile extends TileBase {
  String title;
  IconData iconData;
  TileSize tileSize;
  void Function(BuildContext) onClick;

  SystemTile(this.title, this.iconData, this.tileSize, {Key? key, required this.onClick})
      : super(title, tileSize, key: key, icon: iconData, onPressed: onClick, color: AppColors.GREEN);
}
