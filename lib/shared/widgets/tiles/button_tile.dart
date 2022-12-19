// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_badge_info.dart';
import 'package:xbox_launcher/models/tile_title_bar_info.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_node.dart';
import 'package:xbox_launcher/shared/widgets/focus/focable_element.dart';
import 'package:xbox_launcher/shared/widgets/tiles/models/covered_tile.dart';
import 'package:xbox_launcher/shared/widgets/tiles/models/tile_widget.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_badges.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_cover.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_title_bar.dart';

class ButtonTile extends TileWidget implements CoveredTile, FocableElement {
  final bool interactive;
  @override
  AppBadgeInfo? appBadgeInfo;
  @override
  TileTitleBarInfo? tileTitleBarInfo;
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

  ButtonTile(
      {super.key,
      required TileSize tileSize,
      this.interactive = false,
      this.appBadgeInfo,
      this.tileTitleBarInfo,
      super.color,
      super.onPressed,
      this.icon,
      this.customCover,
      this.image,
      this.elementValue,
      this.focusNode})
      : super(tileSize: tileSize) {
    focusNode?.setFocucableElement(this);
  }

  @override
  State<TileWidget> createState() => _ButtonTileState();
}

class _ButtonTileState extends TileWidgetState<ButtonTile> {
  late FocusNode _focusNode;
  TileTitleBar? _titleBar;
  TileBadges? _tileBadges;

  @override
  void initState() {
    super.initState();

    _focusNode = widget.focusNode ?? FocusNode();
    if (widget.appBadgeInfo != null)
      _tileBadges = TileBadges(widget.appBadgeInfo!);

    if (!widget.interactive) return;

    _focusNode.addListener(() {
      if (!mounted) return;

      setState(() {
        if (widget.tileTitleBarInfo != null)
          _titleBar = _focusNode.hasFocus
              ? TileTitleBar(widget.tileTitleBarInfo!.title)
              : null;
        _tileBadges = !_focusNode.hasFocus && widget.appBadgeInfo != null
            ? TileBadges(widget.appBadgeInfo!)
            : null;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  Widget virtualBuild(BuildContext context) {
    return Button(
      focusNode: _focusNode,
      style: ButtonStyle(
          backgroundColor: ButtonState.all(Colors.transparent),
          elevation: ButtonState.all(0),
          padding: ButtonState.all(EdgeInsets.zero)),
      onPressed: () => widget.onPressed?.call(context),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 3.0, vertical: 3.0),
                  child: _tileBadges ?? const SizedBox())),
          Align(
              alignment: Alignment.bottomLeft,
              child: _titleBar ?? const SizedBox())
        ],
      ),
    );
  }
}
