import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_outlined_button.dart';

class IconOutlinedButton extends SystemOutlinedButton {
  final Widget icon;
  final String? text;

  IconOutlinedButton(
      {Key? key,
      required this.icon,
      required this.text,
      required void Function() onPressed})
      : super(
            key: key,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 5),
                text != null ? Text(text) : const SizedBox()
              ],
            ),
            onPressed: onPressed);
}
