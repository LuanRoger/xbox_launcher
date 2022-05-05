import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/tile_base.dart';

class TileGrid extends StatelessWidget {
  late int? selectedTile;
  TileBase Function(BuildContext, int)? itemBuilder;
  List<TileBase>? tiles;
  int? itemCount;

  TileGrid({Key? key, this.itemBuilder, this.tiles, this.itemCount})
      : super(key: key);

  factory TileGrid.build(
      {Key? key,
      required TileBase Function(BuildContext, int)? itemBuilder,
      required int itemCount}) {
    return TileGrid(
      itemBuilder: itemBuilder,
      itemCount: itemCount,
    );
  }

  factory TileGrid.count({Key? key, required List<TileBase> tiles}) {
    return TileGrid(tiles: tiles);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: itemBuilder ??
          (context, index) {
            return tiles![index];
          },
      itemCount: itemCount,
    );
  }
}

class CheckTile extends StatefulWidget {
  Widget child;
  double? height;
  double? width;

  CheckTile({Key? key, required this.child, this.height, this.width})
      : super(key: key);

  @override
  _CheckTileState createState() => _CheckTileState();
}

class _CheckTileState extends State<CheckTile> {
  late bool _checked;
  set setCheck(bool check) {
    _checked = check;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Button(
              style: ButtonStyle(padding: ButtonState.all(EdgeInsets.zero)),
              child: widget.child,
              onPressed: () => setState(() {
                    _checked = !_checked;
                  })),
          if (_checked)
            Align(
                alignment: Alignment.topRight,
                child: CustomPaint(
                    painter: _Triangle(),
                    child: const Icon(
                      FluentIcons.check_mark,
                      color: Colors.black,
                    ))),
        ],
      ),
    );
  }
}

class _Triangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawPath(
        Path()
          ..moveTo(-10, 0)
          ..lineTo(size.width, size.height + 10)
          ..lineTo(size.width, 0),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
