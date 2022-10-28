// ignore_for_file: overridden_fields

import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/buttons/models/system_button_base.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_node.dart';

class SystemOutlinedButton extends OutlinedButton implements SystemButtonBase {
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

  SystemOutlinedButton(
      {super.key,
      required this.content,
      required super.onPressed,
      this.width = 170.0,
      this.height = 70.0,
      ButtonStyle? style,
      this.focusNode})
      : super(
            child: SizedBox(
              width: width,
              height: height,
              child: content,
            ),
            style: style != null
                ? style.copyWith(border: ButtonState.all(BorderSide.none))
                : ButtonStyle(border: ButtonState.all(BorderSide.none))) {
    focusNode?.setFocucableElement(this);
  }
}
