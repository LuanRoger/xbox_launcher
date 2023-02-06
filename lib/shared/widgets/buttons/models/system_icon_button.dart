// ignore_for_file: overridden_fields

import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/widgets/buttons/models/system_button.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_node.dart';

class SystemIconButton extends IconButton implements SystemButton {
  @override
  Widget? content;
  @override
  double? height;
  @override
  double? width;
  @override
  Object? elementValue;
  @override
  ElementFocusNode? focusNode;

  SystemIconButton(
      {super.key,
      required super.icon,
      required super.onPressed,
      this.elementValue,
      this.focusNode,
      ButtonStyle? style})
      : super(
          focusNode: focusNode,
          style: style ??
              ButtonStyle(
                  backgroundColor: ButtonState.all(AppColors.ELEMENT_BG)),
        ) {
          focusNode?.setFocucableElement(this);
        }
}
