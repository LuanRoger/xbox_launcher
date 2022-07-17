import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/system_text_box.dart';
import 'package:xbox_launcher/shared/widgets/keyboard/keyboard_overlay.dart';

class KeyboardButton extends StatelessWidget {
  String placeholder;
  TextEditingController controller;
  int? maxLenght;

  KeyboardButton(
      {Key? key,
      required this.placeholder,
      required this.controller,
      this.maxLenght})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      child: SystemTextBox(
        controller: controller,
        placeholder: placeholder,
        maxLenght: maxLenght,
        readOnly: true,
      ),
      onPressed: () => KeyboardOverlay(controller: controller).show(context),
      style: ButtonStyle(
          padding: ButtonState.all(EdgeInsets.zero),
          shape: ButtonState.all(
              const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
          foregroundColor: ButtonState.all(Colors.black)),
    );
  }
}
