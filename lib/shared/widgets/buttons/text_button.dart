import 'package:flutter/material.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_button.dart';

class TextButton extends SystemButton {
  final String title;

  TextButton(
      {Key? key, required this.title, required void Function() onPressed})
      : super(
            key: key,
            content: Row(
              children: [
                Text(
                  title,
                  style: AppTextStyle.SYSTEM_BUTTON_TEXT,
                )
              ],
            ),
            onPressed: onPressed);
}
