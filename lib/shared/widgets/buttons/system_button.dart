import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_colors.dart';

abstract class SystemButton extends Button {
  final Widget content;
  final double? height;
  final double? width;

  SystemButton(
      {super.key,
      required this.content,
      super.onPressed,
      this.width = 170.0,
      this.height = 70.0,
      ButtonStyle? style,
      super.focusNode})
      : super(
          style: style ??
              ButtonStyle(
                  backgroundColor: ButtonState.all(AppColors.ELEMENT_BG)),
          child: SizedBox(height: height, width: width, child: content),
        );
}
