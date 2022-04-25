import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/tile_title_bar.dart';

class TileBase extends StatefulWidget {
  String title;
  TileSize tileSize;
  Color? color;
  IconData? icon;
  ImageProvider? image;
  Function(BuildContext)? onPressed;

  late double _tileWidth;
  late double _tileHeight;

  late Widget tileCover;

  //TODO: Separate by lenght in factory
  TileBase(this.title, this.tileSize,
      {Key? key,
      this.color = Colors.transparent,
      this.onPressed,
      this.icon,
      this.image})
      : super(key: key) {
    switch (tileSize) {
      case TileSize.SMALL:
        _tileWidth = 100;
        _tileHeight = 100;
        break;
      case TileSize.MEDIUM:
        _tileHeight = 150;
        _tileWidth = 150;
        break;
      case TileSize.BIG:
        _tileWidth = 300;
        _tileHeight = 300;
        break;
      case TileSize.LENGHTY:
        _tileWidth = 200;
        _tileHeight = 100;
        break;
    }

    if (image != null) {
      tileCover = Image(
        image: image!,
        width: _tileWidth,
        height: _tileHeight,
        fit: BoxFit.cover,
      );
    } else if (icon != null) {
      tileCover = Align(
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: Colors.white,
          size: 35,
        ),
      );
    } else {
      color = AppColors.GREEN;
      tileCover = Center(
          child: Text(
        title[0],
        style: AppTextStyle.TILE_PLACEHOLDER,
      ));
    }
  }

  @override
  State<TileBase> createState() => _TileBaseState();
}

class _TileBaseState extends State<TileBase> {
  final focusNode = FocusNode();
  late bool getFocused;
  TileTitleBar? titleBar;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      setState(() {
        titleBar = focusNode.hasFocus ? TileTitleBar(widget.title) : null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      width: widget._tileWidth,
      height: widget._tileHeight,
      child: Focus(
        focusNode: focusNode,
        child: Button(
          style: ButtonStyle(
              backgroundColor: ButtonState.all(Colors.transparent),
              elevation: ButtonState.all(0),
              padding: ButtonState.all(EdgeInsets.zero)),
          onPressed: () => widget.onPressed!(context),
          child: Stack(
            children: [
              widget.tileCover,
              Align(
                  alignment: Alignment.bottomLeft,
                  child: titleBar ?? const SizedBox())
            ],
          ),
        ),
      ),
    );
  }
}
