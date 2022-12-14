import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_badge_info.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_node.dart';
import 'package:xbox_launcher/shared/widgets/focus/focable_element.dart';
import 'package:xbox_launcher/shared/widgets/tiles/models/covered_tile.dart';
import 'package:xbox_launcher/shared/widgets/tiles/models/tile_widget.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_cover.dart';

class ButtonTile extends TileWidget implements CoveredTile, FocableElement {
  final bool interactive;
  @override
  AppBadgeInfo? appBadgeInfo;
  @override
  IconData? icon;
  @override
  Widget? customCover;
  final ImageProvider? image;

  @override
  Object? elementValue;

  @override
  ElementFocusNode? focusNode;

  late bool getFocused;

  ButtonTile(String title,
      {super.key,
      required TileSize tileSize,
      this.interactive = false,
      this.appBadgeInfo,
      super.color,
      super.onPressed,
      this.icon,
      this.customCover,
      this.image,
      this.elementValue,
      this.focusNode})
      : super(tileSize: tileSize);

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
