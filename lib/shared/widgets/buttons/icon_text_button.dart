import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/buttons/models/system_button.dart';

class IconTextButton extends SystemButton {
  final IconData icon;
  final String title;
  final bool bigMode;

  IconTextButton(
      {super.key,
      required this.title,
      required this.icon,
      this.bigMode = false,
      required super.onPressed,
      super.width,
      super.height,
      super.focusNode,
      super.style})
      : super(
            content: bigMode
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(flex: 2, child: Icon(icon, size: 30)),
                      const Spacer(),
                      Flexible(
                        flex: 3,
                        child: Text(
                          title,
                          style: AppTextStyle.SYSTEM_BUTTON_TEXT,
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  )
                : Row(children: [
                    Icon(icon, size: 25),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      title,
                      style: AppTextStyle.SYSTEM_BUTTON_TEXT,
                    )
                  ]));
}
