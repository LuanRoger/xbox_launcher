import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/buttons/models/system_button.dart';

class IconButton extends SystemButton {
  IconButton(
      {super.key,
      required IconData icon,
      double? iconSize,
      required super.onPressed,
      super.width,
      super.height,
      super.focusNode,
      super.style})
      : super(
            content: Icon(
          icon,
          size: iconSize,
        ));
}
