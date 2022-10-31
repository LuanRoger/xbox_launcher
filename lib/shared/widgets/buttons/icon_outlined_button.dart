import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/buttons/models/system_outlined_button.dart';

class IconTextOutlinedButton extends SystemOutlinedButton {
  IconTextOutlinedButton(
      {Key? key,
      required String title,
      required IconData icon,
      required super.onPressed,
      super.width,
      super.height,
      super.focusNode})
      : super(
            key: key,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, size: 25),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: AppTextStyle.SYSTEM_BUTTON_TEXT,
                )
              ],
            ));
}
