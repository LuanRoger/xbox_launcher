import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_button.dart';

class SystemBannerButton extends SystemButton {
  String text;
  void Function() onClick;
  IconData? icon;
  ImageProvider? backgroundImage;
  double? height;
  double? width;

  SystemBannerButton(this.text,
      {Key? key,
      required this.onClick,
      this.icon,
      this.backgroundImage,
      this.height = 140,
      this.width = 240})
      : super(
            key: key,
            width: width,
            height: height,
            content: Builder(builder: ((BuildContext context) {
              if (icon != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      icon,
                      size: 26,
                    ),
                    Text(
                      text,
                      style: AppTextStyle.SYSTEM_BUTTON_TEXT,
                    )
                  ],
                );
              } else if (backgroundImage != null) {
                return Stack(
                  children: [
                    Image(
                      image: backgroundImage,
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(text),
                    )
                  ],
                );
              }

              return const SizedBox();
            })),
            onPressed: onClick);
}