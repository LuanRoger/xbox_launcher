import 'package:fluent_ui/fluent_ui.dart';

abstract class TileBase extends Widget {
  double width;
  double height;
  Color color;

  TileBase({required this.width, required this.height, required this.color});
}
