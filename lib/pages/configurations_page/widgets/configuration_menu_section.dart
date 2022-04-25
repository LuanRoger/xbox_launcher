import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/system_button.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

class ConfigurationMenuSection extends StatelessWidget {
  String? title;
  List<SystemButton> buttons;

  ConfigurationMenuSection({this.title, required this.buttons, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            child: title == null
                ? const SizedBox()
                : Text(
                    title!,
                    style: AppTextStyle.CONFIGURATION_MENU_SECTION_TITLE,
                  )),
        const Spacer(),
        Flexible(flex: 15, child: Column(children: buttons))
      ],
    );
  }
}
