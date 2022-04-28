import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/pages/configurations_page/widgets/configuration_menu_section.dart';
import 'package:xbox_launcher/pages/models/xbox_page.dart';
import 'package:xbox_launcher/shared/widgets/system_button.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

abstract class ConfigurationMenu extends XboxPage {
  String routeName;
  String menuTitle;
  Map<String?, List<SystemButton>> buttons;

  ConfigurationMenu(this.routeName, this.menuTitle,
      {Key? key,
      Map<ControllerKeyboardPair, void Function(BuildContext)>? keyAction,
      required this.buttons})
      : super(key: key, keyAction: keyAction);

  @override
  Widget virtualBuild(BuildContext context) {
    return Container(
      color: AppColors.DARK_BG,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 50, 250, 50),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Flexible(
            flex: 0,
            child: Row(
              children: [
                Flexible(
                  flex: 0,
                  child: Text(
                    routeName,
                    style: AppTextStyle.CONFIGURATION_PAGES_ROUTE_TITLE,
                  ),
                ),
                const Spacer(),
                Flexible(
                  flex: 60,
                  child: Text(
                    menuTitle,
                    style: AppTextStyle.CONFIGURATION_PAGES_TITLE,
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          Flexible(
              flex: 10,
              child: _ConfigurationMenuButtonsSet(
                buttons: buttons,
              ))
        ]),
      ),
    );
  }
}

class _ConfigurationMenuButtonsSet extends StatelessWidget {
  Map<String?, List<SystemButton>> buttons;

  _ConfigurationMenuButtonsSet({required this.buttons, Key? key})
      : super(key: key);

  List<ConfigurationMenuSection> generateSet() {
    List<ConfigurationMenuSection> sections = List.empty(growable: true);

    buttons.forEach((key, value) {
      sections.add(ConfigurationMenuSection(title: key, buttons: value));
    });

    return sections;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: generateSet());
  }
}
