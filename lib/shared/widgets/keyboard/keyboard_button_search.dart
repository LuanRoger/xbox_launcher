import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/keyboard/keyboard_button.dart';

class KeyboardButtonSearch extends StatelessWidget {
  String placeholder;
  TextEditingController controller;
  void Function(String value) onChenged;

  KeyboardButtonSearch(this.placeholder, this.controller,
      {Key? key, required this.onChenged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(FluentIcons.search),
        KeyboardButton(
          placeholder: placeholder,
          controller: controller,
          onChanged: onChenged,
        )
      ],
    );
  }
}
