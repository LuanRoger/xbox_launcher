import 'package:fluent_ui/fluent_ui.dart' hide IconButton;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:xbox_launcher/shared/widgets/keyboard/keyboard_overlay.dart';

class SearchButton extends HookWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function(bool)? onFinish;
  final double? width;
  final double? height;

  const SearchButton(
      {Key? key,
      required this.controller,
      this.onChanged,
      this.onFinish,
      this.width = 200.0,
      this.height = 40.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showTextState = useState<String>("");
    final internalTextControllerState =
        useTextEditingController(text: controller.text);
    internalTextControllerState.addListener(
        () => showTextState.value = internalTextControllerState.text);

    return SizedBox(
      width: width,
      height: height,
      child: Button(
        onPressed: () async {
          final keyboardHandler = KeyboardOverlay(
              controller: controller,
              context: context,
              onFinish: onChanged == null ? onFinish : null,
              onChanged: onFinish == null ? onChanged : null);

          await keyboardHandler.show();
          keyboardHandler.dispose();
        },
        child: Row(children: [
          const Icon(FluentIcons.search),
          const SizedBox(
            width: 5,
          ),
          Text(
            controller.text.isNotEmpty ? controller.text : "Search",
            overflow: TextOverflow.fade,
          ),
        ]),
        style: ButtonStyle(border: ButtonState.all(BorderSide.none)),
      ),
    );
  }
}
