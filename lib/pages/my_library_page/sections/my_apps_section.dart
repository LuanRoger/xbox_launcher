import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/controllers/system_app_controller.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section.dart';
import 'package:xbox_launcher/shared/widgets/tiles/apps_tiles_grid.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';

class MyAppsSection extends NavigationSection {
  const MyAppsSection({super.key, super.currentScope}) : super("Apps");

  @override
  List<Widget>? titleActions(BuildContext context) => null;

  @override
  List<Widget> columnItems(BuildContext context) {
    return [
      Expanded(
          flex: 7,
          child: AppsTilesGrid(
            apps: SystemAppController.systemApps,
            customGenerationOption:
                TileGeneratorOption(focusScope: currentScope, context: context),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            scrollDirection: Axis.vertical,
          ))
    ];
  }
}
