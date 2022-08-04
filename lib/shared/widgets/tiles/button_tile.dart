import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_base_stateful.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_cover.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_title_bar.dart';

class ButtonTile extends TileBaseStateful {
  String title;
  bool interactive;
  IconData? icon;
  Widget? customCover;
  ImageProvider? image;
  void Function(BuildContext)? onPressed;

  @override
  Color? color;
  @override
  late double height;
  @override
  late double width;

  late TileSize _tileSize;
  TileSize get tileSize => _tileSize;

  @override
  State<StatefulWidget> createState() => _ButtonTileState();

  ButtonTile(this.title,
      {Key? key,
      required TileSize tileSize,
      this.interactive = false,
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
  TileTitleBar? titleBar;

  @override
  void initState() {
    super.initState();
    if (widget.interactive) {
      focusNode.addListener(() {
        setState(() {
          titleBar = focusNode.hasFocus ? TileTitleBar(widget.title) : null;
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
              child: titleBar ?? const SizedBox())
        ],
      ),
    );
  }
}
