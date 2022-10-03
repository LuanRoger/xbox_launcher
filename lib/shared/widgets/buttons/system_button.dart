import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_colors.dart';

abstract class SystemButton extends Button {
  final Widget content;
  final double? height;
  final double? width;
  @override
  ButtonStyle? style;

  SystemButton(
      {Key? key,
      required this.content,
      required void Function() onPressed,
      this.width = 170.0,
      this.height = 70.0,
      this.style})
      : super(
          key: key,
          onPressed: onPressed,
          style: style ?? ButtonStyle(
              backgroundColor: ButtonState.all(AppColors.ELEMENT_BG)),
          child: SizedBox(height: height, width: width, child: content),
        );
}
