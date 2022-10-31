import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/buttons/models/system_button.dart';

class IconTextButton extends SystemButton {
  IconTextButton(
      {super.key,
      required String title,
      required IconData icon,
      required super.onPressed,
      super.width,
      super.height,
      super.focusNode})
      : super(
            content: Row(children: [
          Icon(icon, size: 25),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: AppTextStyle.SYSTEM_BUTTON_TEXT,
          )
        ]));
}
