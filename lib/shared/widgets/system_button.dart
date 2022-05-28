import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

class SystemButton extends Button {
  String title;
  String? subtitle;
  IconData? icon;
  double? height;
  double? width;

  //TODO: Made a default size (width, height)
  SystemButton(this.title,
      {Key? key,
      required void Function() onPressed,
      this.icon,
      this.subtitle,
      this.height,
      this.width})
      : super(
          key: key,
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor: ButtonState.all(AppColors.ELEMENT_BG)),
          child: SizedBox(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    icon != null ? Icon(icon, size: 25) : const SizedBox(),
                    SizedBox(width: icon != null ? 10 : 0),
                    Text(
                      title,
                      style: AppTextStyle.SYSTEM_BUTTON_TEXT,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
}
