import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/controllers/keyboard_controller_action_manipulator.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/pages/configurations_page/widgets/configuration_menu_section.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateless.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_button.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

abstract class ConfigurationMenu extends XboxPageStateless {
  String routeName;
  String menuTitle;

  ConfigurationMenu(this.routeName, this.menuTitle,
      {Key? key,
      required Map<ControllerKeyboardPair, void Function(BuildContext)>
          pageKeysAction})
      : super(key: key, pageKeysAction: pageKeysAction);

  Map<String, List<SystemButton>> buttonsBuilder(BuildContext context);

  @override
  Widget virtualBuild(BuildContext context) {
    return Padding(
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
              buttons: buttonsBuilder(context),
            ))
      ]),
    );
  }
}

class _ConfigurationMenuButtonsSet extends StatelessWidget {
  Map<String, List<SystemButton>> buttons;

  _ConfigurationMenuButtonsSet({required this.buttons, Key? key})
      : super(key: key);

  List<Widget> generateSet() {
    List<Widget> sections = List.empty(growable: true);

    buttons.forEach((key, value) {
      sections.add(Flexible(
          flex: 10, child: ConfigurationMenuSection(key, buttons: value)));
      sections.add(const Spacer());
    });

    return sections;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: generateSet());
  }
}
