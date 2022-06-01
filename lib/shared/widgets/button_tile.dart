import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/providers/theme_data_profile.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/tile_base_stateful.dart';
import 'package:xbox_launcher/shared/widgets/tile_title_bar.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/widget_gen.dart';

class ButtonTile extends TileBaseStateful {
  String title;
  bool interactive;
  IconData? icon;
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

  ButtonTile(this.title, this.interactive,
      {Key? key,
      required TileSize tileSize,
      this.color,
      this.onPressed,
      this.icon,
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

  @override
  State<StatefulWidget> vitualCreateState() => _ButtonTileState();
}

class _ButtonTileState extends TileBaseStatefulState<ButtonTile> {
  final focusNode = FocusNode();
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
          Consumer<ProfileProvider>(
              builder: (_, value, __) => WidgetGen.generateTileCover(
                  colorByGenerator: value.accentColor,
                  color: widget.color,
                  icon: widget.icon,
                  image: widget.image)),
          Align(
              alignment: Alignment.bottomLeft,
              child: titleBar ?? const SizedBox())
        ],
      ),
    );
  }
}
