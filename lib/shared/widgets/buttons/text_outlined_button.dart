import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/buttons/models/system_outlined_button.dart';

class TextOutlinedButton extends SystemOutlinedButton {
  TextOutlinedButton(
      {super.key,
      required String title,
      TextStyle? textStyle,
      required super.onPressed,
      super.width,
      super.height,
      super.focusNode})
      : super(
            content: Text(
              title,
              textAlign: TextAlign.start,
              style: textStyle ?? AppTextStyle.APPS_GROUP_TITLE,
            ),
            style: ButtonStyle(
                backgroundColor: ButtonState.all(Colors.transparent),
                shadowColor: ButtonState.all(Colors.transparent),
                border: ButtonState.all(BorderSide.none)));
}
