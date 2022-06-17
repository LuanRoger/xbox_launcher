import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_button.dart';

class IconTextButton extends SystemButton {
  String title;
  IconData icon;

  IconTextButton(
      {required this.title,
      required this.icon,
      required void Function() onPressed})
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
            ]),
            onPressed: onPressed);
}
