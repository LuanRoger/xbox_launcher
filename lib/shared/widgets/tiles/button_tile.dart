import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_badge_info.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/tiles/models/covered_tile.dart';
import 'package:xbox_launcher/shared/widgets/tiles/models/tile_widget.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_cover.dart';

class ButtonTile extends TileWidget implements CoveredTile {
  final bool interactive;
  @override
  AppBadgeInfo? appBadgeInfo;
  @override
  IconData? icon;
  @override
  Widget? customCover;
  final ImageProvider? image;

  late bool getFocused;

  late final TileSize _tileSize;
  TileSize get tileSize => _tileSize;

  ButtonTile(String title,
      {super.key,
      required TileSize tileSize,
      this.interactive = false,
      this.appBadgeInfo,
      super.color,
      super.onPressed,
      this.icon,
      this.customCover,
      this.image})
      : super(title: title) {
    _tileSize = tileSize;
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
  Widget virtualBuild(BuildContext context) {
    return Button(
      style: ButtonStyle(
          backgroundColor: ButtonState.all(Colors.transparent),
          elevation: ButtonState.all(0),
          padding: ButtonState.all(EdgeInsets.zero)),
      onPressed: () => onPressed?.call(context),
      child: Stack(
        children: [
          TileCover(
            customCover: customCover,
            icon: icon,
            image: image,
            color: color,
          ),
        ],
      ),
    );
  }
}
