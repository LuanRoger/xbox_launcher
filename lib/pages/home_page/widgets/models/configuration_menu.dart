import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/pages/home_page/widgets/system_button.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

abstract class ConfigurationMenu extends StatelessWidget {
  String routName;
  String menuTitle;
  List<SystemButton> buttons;

  ConfigurationMenu(this.routName, this.menuTitle,
      {Key? key, required this.buttons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    routName,
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
            flex: 5,
            child: GridView.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.3,
              crossAxisCount: 5,
              scrollDirection: Axis.horizontal,
              children: buttons,
            ),
          )
        ]),
      ),
    );
  }
}
