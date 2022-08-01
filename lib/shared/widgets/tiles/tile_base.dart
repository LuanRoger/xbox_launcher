import 'package:fluent_ui/fluent_ui.dart';

abstract class TileBase extends Widget {
  double width;
  double height;
  Color? color;
  FocusNode? focusNode;

  TileBase(
      {required this.width,
      required this.height,
      this.focusNode,
      this.color});
}
