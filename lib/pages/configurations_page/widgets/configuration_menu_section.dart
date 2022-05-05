import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/system_button.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

class ConfigurationMenuSection extends StatelessWidget {
  String title;
  List<SystemButton> buttons;

  ConfigurationMenuSection(this.title, {required this.buttons, Key? key})
      : super(key: key);

  List<Widget> generateButtonsSet() {
    List<Widget> buttonsSet = List.empty(growable: true);

    buttons.forEach((element) {
      buttonsSet.add(Flexible(flex: 10, child: element));
      buttonsSet.add(const Spacer());
    });

    return buttonsSet;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            child: Text(
          title,
          style: AppTextStyle.CONFIGURATION_MENU_SECTION_TITLE,
        )),
        const Spacer(),
        Flexible(flex: 15, child: Column(children: generateButtonsSet()))
      ],
    );
  }
}
