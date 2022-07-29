import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/controllers/system_app_controller.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section.dart';
import 'package:xbox_launcher/shared/widgets/tile_grid.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/widget_gen.dart';

class MyAppsSection extends NavigationSection {
  MyAppsSection({Key? key}) : super("Apps", key: key);

  @override
  List<Widget>? buildActions(BuildContext context) => null;

  @override
  List<Widget> buildColumnItems(BuildContext context) => [
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
            ))
      ];
}
