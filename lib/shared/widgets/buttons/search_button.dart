import 'package:fluent_ui/fluent_ui.dart' hide IconButton;
import 'package:xbox_launcher/shared/widgets/keyboard/keyboard_overlay.dart';

class SearchButton extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function(bool)? onFinish;
  final double? width;
  final double? height;

  void Function(void Function())? _reloadText;

  SearchButton(
      {Key? key,
      required this.controller,
      this.onChanged,
      this.onFinish,
      this.width = 200.0,
      this.height = 40.0})
      : super(key: key) {
    controller.addListener(() => _reloadText?.call(() {}));
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Button(
        onPressed: () => KeyboardOverlay(
                controller: controller,
                onFinish: onChanged == null ? onFinish : null,
                onChanged: onFinish == null ? onChanged : null)
            .show(context),
        child: Row(children: [
          const Icon(FluentIcons.search),
          const SizedBox(
            width: 5,
          ),
          StatefulBuilder(
            builder: (_, setState) {
              _reloadText = setState;

              return Text(
                controller.text.isNotEmpty ? controller.text : "Search",
                overflow: TextOverflow.fade,
              );
            },
          )
        ]),
        style: ButtonStyle(border: ButtonState.all(BorderSide.none)),
      ),
    );
  }
}
