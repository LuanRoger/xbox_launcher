import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_colors.dart';

abstract class SystemButton extends Button {
  Widget content;
  double? height;
  double? width;

  SystemButton(
      {Key? key,
      required this.content,
      required void Function() onPressed,
      this.width = 170.0,
      this.height = 70.0})
      : super(
          key: key,
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor: ButtonState.all(AppColors.ELEMENT_BG)),
          child: SizedBox(height: height, width: width, child: content),
        );
}
