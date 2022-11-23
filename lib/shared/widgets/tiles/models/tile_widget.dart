import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class TileWidget extends HookConsumerWidget {
  String? title;
  void Function(BuildContext, WidgetRef)? onPressed;
  late double width;
  late double height;
  Color? color;

  TileWidget({super.key, this.title, required this.color, this.onPressed});

  Widget virtualBuild(BuildContext context, WidgetRef ref);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: color,
      width: width,
      height: height,
      child: virtualBuild(useContext(), ref),
    );
  }
}
