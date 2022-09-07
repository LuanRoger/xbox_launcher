import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_button.dart';

class CheckButton extends SystemButton {
  final String title;
  final bool checked;
  final Color? color;
  final void Function(bool)? onChange;

  CheckButton(
      {Key? key,
      required this.title,
      required this.checked,
      required void Function() onPressed,
      required this.onChange,
      this.color})
      : super(
            key: key,
            content: Row(
              children: [
                Checkbox(
                    checked: checked,
                    style: CheckboxThemeData(
                        checkedDecoration:
                            ButtonState.all(BoxDecoration(color: color)),
                        uncheckedDecoration: ButtonState.all(BoxDecoration(
                            border: Border.all(
                                color: AppColors.DARK_BG, width: 10)))),
                    onChanged: (value) => onChange?.call(value!)),
                Text(
                  title,
                  style: AppTextStyle.SYSTEM_BUTTON_TEXT,
                )
              ],
            ),
            onPressed: onPressed);
}
