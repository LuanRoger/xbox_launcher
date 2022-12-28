import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_info.dart';
import 'package:xbox_launcher/shared/widgets/buttons/button_grid.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page.dart';

abstract class ConfigurationMenu extends XboxPage {
  final String routeName;
  final String menuTitle;

  const ConfigurationMenu(this.routeName, this.menuTitle, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConfigurationMenuState();

  List<ButtonGridGroup> buttonsBuilder(BuildContext context);

  //Redirect to state
  List<ShortcutInfo>? defineMapping(BuildContext context);
}

class _ConfigurationMenuState extends XboxPageState<ConfigurationMenu> {
  @override
  List<ShortcutInfo>? defineMapping(BuildContext context) =>
      widget.defineMapping(context);

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
                  widget.routeName,
                  style: AppTextStyle.CONFIGURATION_PAGES_ROUTE_TITLE,
                ),
              ),
              const Spacer(),
              Flexible(
                flex: 60,
                child: Text(
                  widget.menuTitle,
                  style: AppTextStyle.CONFIGURATION_PAGES_TITLE,
                ),
              )
            ],
          ),
        ),
        const Spacer(),
        Flexible(
            flex: 10,
            child: ButtonGrid(
              buttons: widget.buttonsBuilder(context),
            ))
      ]),
    );
  }
}
