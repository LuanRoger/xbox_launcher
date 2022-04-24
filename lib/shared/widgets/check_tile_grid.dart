import 'package:fluent_ui/fluent_ui.dart';

class CheckTileGrid extends StatelessWidget {
  const CheckTileGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
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

  @override
  void initState() {
    _checked = false;
    super.initState();
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
