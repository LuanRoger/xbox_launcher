import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:xbox_launcher/models/app_badge_info.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_node.dart';
import 'package:xbox_launcher/shared/widgets/focus/focable_element.dart';
import 'package:xbox_launcher/shared/widgets/tiles/models/covered_tile.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_badges.dart';
import 'package:xbox_launcher/shared/widgets/tiles/models/tile_widget.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_cover.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_title_bar.dart';

class ButtonTileInteractive extends TileWidget
    implements FocableElement, CoveredTile {
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

  late final TileSize _tileSize;
  TileSize get tileSize => _tileSize;

  ButtonTileInteractive(String title,
      {super.key,
      required TileSize tileSize,
      required this.focusNode,
      this.appBadgeInfo,
      super.color,
      super.onPressed,
      this.icon,
      this.customCover,
      this.image,
      this.elementValue})
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

    focusNode?.setCurrentElement(this);
  }

  @override
  Widget virtualBuild(BuildContext context) {
    final titleBarState = useState<TileTitleBar?>(null);
    final tileBadgeState = useState<TileBadges?>(
        appBadgeInfo != null ? TileBadges(appBadgeInfo!)
            : null);
    final isMounted = useIsMounted();

    focusNode?.addListener(() {
      if (!isMounted()) return;
      titleBarState.value = focusNode!.hasFocus ? TileTitleBar(title!) : null;
      tileBadgeState.value = !focusNode!.hasFocus && appBadgeInfo != null
          ? TileBadges(appBadgeInfo!)
          : null;
    });

    return Button(
      focusNode: focusNode,
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
          Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                  padding:
                      const EdgeInsets.only(left: 3.0, right: 3.0, bottom: 3.0),
                  child: tileBadgeState.value ?? const SizedBox())),
          Align(
              alignment: Alignment.bottomLeft,
              child: titleBarState.value ?? const SizedBox())
        ],
      ),
    );
  }
}
