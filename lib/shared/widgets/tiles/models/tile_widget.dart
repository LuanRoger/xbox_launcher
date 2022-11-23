import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

abstract class TileWidget extends HookWidget {
  String? title;
  void Function(BuildContext)? onPressed;
  late double width;
  late double height;
  Color? color;

  TileWidget({super.key, this.title, required this.color, this.onPressed});

  Widget virtualBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: width,
      height: height,
      child: virtualBuild(context),
    );
  }
}
