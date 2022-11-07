import 'package:flutter/material.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/buttons/models/system_button.dart';

class TextButton extends SystemButton {
  TextButton(
      {super.key,
      required String title,
      TextStyle? textStyle,
      required super.onPressed,
      super.height,
      super.width,
      super.style,
      super.focusNode})
      : super(
            content: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: textStyle ?? AppTextStyle.SYSTEM_BUTTON_TEXT,
          ),
        ));
}
