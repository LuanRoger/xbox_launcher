import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/keyboard/keyboard_overlay.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_text_box.dart';

class KeyboardButton extends StatelessWidget {
  final String placeholder;
  final TextEditingController controller;
  final int? maxLenght;
  final void Function(bool cancel)? onFinish;
  final void Function(String value)? onChanged;

  const KeyboardButton(
      {super.key,
      required this.placeholder,
      required this.controller,
      this.maxLenght,
      this.onFinish,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Button(
      child: SystemTextBox(
        controller: controller,
        placeholder: placeholder,
        maxLength: maxLenght,
        readOnly: true,
      ),
      onPressed: () async {
        final keyboardHandler = KeyboardOverlay(
            controller: controller, onFinish: onFinish, onChanged: onChanged);

        await keyboardHandler.show(context);
        keyboardHandler.dispose();
      },
      style: ButtonStyle(
          padding: ButtonState.all(EdgeInsets.zero),
          shape: ButtonState.all(
              const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
          foregroundColor: ButtonState.all(Colors.black)),
    );
  }
}
