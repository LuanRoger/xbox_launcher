import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_button.dart';

class IconTextButton extends SystemButton {
  IconTextButton(
      {Key? key,
      required String title,
      required IconData icon,
      double? width = 170.0,
      double? height = 70.0,
      required void Function() onPressed})
      : super(
            key: key,
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
            width: width,
            height: height,
            onPressed: onPressed);
}
