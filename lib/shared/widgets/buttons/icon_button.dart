import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_button.dart';

class IconButton extends SystemButton {
  IconButton(
      {Key? key,
      required IconData icon,
      required void Function() onPressed,
      double? width,
      double? height})
      : super(
            key: key,
            content: Icon(icon),
            onPressed: onPressed,
            width: width,
            height: height);
}
