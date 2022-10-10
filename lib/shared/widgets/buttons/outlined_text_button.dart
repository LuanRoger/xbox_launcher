import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart';

class OutlinedTextButton extends TextButton {
  OutlinedTextButton(
      {super.key, required super.title, required super.onPressed})
      : super(
            textStyle: AppTextStyle.APPS_GROUP_TITLE,
            style: ButtonStyle(
                backgroundColor: ButtonState.all(Colors.transparent),
                shadowColor: ButtonState.all(Colors.transparent),
                border: ButtonState.all(BorderSide.none)),
            height: null);
}
