import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_badge_info.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_badges.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_base_stateful.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_cover.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_title_bar.dart';

class ButtonTile extends TileBaseStateful {
  final String title;
  final bool interactive;
  final AppBadgeInfo? appBadgeInfo;
  final IconData? icon;
  final Widget? customCover;
  final ImageProvider? image;
  final void Function(BuildContext)? onPressed;

  @override
  final Color? color;
  @override
  late final double height;
  @override
  late final double width;

  late final TileSize _tileSize;
  TileSize get tileSize => _tileSize;

  @override
  State<StatefulWidget> createState() => _ButtonTileState();

  ButtonTile(this.title,
      {Key? key,
      required TileSize tileSize,
      this.interactive = false,
      this.appBadgeInfo,
      this.color,
      this.onPressed,
      this.icon,
      this.customCover,
      this.image})
      : super(key: key) {
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
}

class _ButtonTileState extends TileBaseStatefulState<ButtonTile> {
  final FocusNode focusNode = FocusNode();
  late bool getFocused;
  TileTitleBar? _titleBar;
  TileBadges? _tileBadges;

  @override
  void initState() {
    super.initState();

    if (widget.appBadgeInfo != null) {
      _tileBadges = TileBadges(widget.appBadgeInfo!);
    }

    if (widget.interactive) {
      focusNode.addListener(() {
        setState(() {
          _titleBar = focusNode.hasFocus ? TileTitleBar(widget.title) : null;
          _tileBadges = !focusNode.hasFocus && widget.appBadgeInfo != null
              ? TileBadges(widget.appBadgeInfo!)
              : null;
        });
      });
    }
  }

  @override
  Widget virtualBuild(BuildContext context) {
    return Button(
      focusNode: focusNode,
      style: ButtonStyle(
          backgroundColor: ButtonState.all(Colors.transparent),
          elevation: ButtonState.all(0),
          padding: ButtonState.all(EdgeInsets.zero)),
      onPressed: () => widget.onPressed!(context),
      child: Stack(
        children: [
          TileCover(
            customCover: widget.customCover,
            icon: widget.icon,
            image: widget.image,
            color: widget.color,
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                  padding:
                      const EdgeInsets.only(left: 3.0, right: 3.0, bottom: 3.0),
                  child: _tileBadges ?? const SizedBox())),
          Align(
              alignment: Alignment.bottomLeft,
              child: _titleBar ?? const SizedBox())
        ],
      ),
    );
  }
}
