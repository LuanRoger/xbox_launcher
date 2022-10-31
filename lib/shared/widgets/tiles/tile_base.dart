import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/focus/focable_element.dart';

abstract class TileBase extends Widget implements FocableElement {
  final double width;
  final double height;
  final Color? color;

  const TileBase(
      {Key? key, required this.width, required this.height, this.color})
      : super(key: key);
}
