import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/controllers/system_app_controller.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/tile_grid.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/widget_gen.dart';

class MyAppsSection extends StatelessWidget {
  const MyAppsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Flexible(
              child: Text(
            "Apps",
            style: AppTextStyle.MY_APPS_SECTIONS_TILE,
          )),
          const Spacer(),
          Expanded(
              flex: 7,
              child: TileGrid.count(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                tiles: WidgetGen.generateSystemAppsTiles(
                    SystemAppController.systemApps, context),
                scrollDirection: Axis.vertical,
              )),
        ],
      ),
    );
  }
}
