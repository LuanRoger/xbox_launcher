// ignore_for_file: overridden_fields

import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/widgets/buttons/models/system_button_base.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_node.dart';

abstract class SystemButton extends Button implements SystemButtonBase {
  @override
  Widget content;
  @override
  double? height;
  @override
  double? width;
  @override
  Object? elementValue;
  @override
  ElementFocusNode? focusNode;

  SystemButton(
      {super.key,
      required this.content,
      super.onPressed,
      this.width = 170.0,
      this.height = 70.0,
      ButtonStyle? style,
      this.focusNode})
      : super(
          focusNode: focusNode,
          style: style ??
              ButtonStyle(
                  backgroundColor: ButtonState.all(AppColors.ELEMENT_BG)),
          child: SizedBox(height: height, width: width, child: content),
        );
}
