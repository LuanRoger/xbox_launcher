import 'package:flutter/material.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_button.dart';

class TextButton extends SystemButton {
  final String title;
  TextStyle? textStyle;

  TextButton(
      {Key? key,
      required this.title,
      required void Function() onPressed,
      this.textStyle,
      super.height,
      super.width,
      super.style})
      : super(
            key: key,
            content: Row(
              children: [
                Text(
                  title,
                  style: textStyle ?? AppTextStyle.SYSTEM_BUTTON_TEXT,
                )
              ],
            ),
            onPressed: onPressed);
}
