import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/controllers/system_app_controller.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section_stateless.dart';
import 'package:xbox_launcher/shared/widgets/tiles/apps_tile_grid.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';

class MyAppsSection extends NavigationSectionStateless {
  const MyAppsSection({super.key, required super.currentScope}) : super("Apps");

  @override
  List<Widget>? titleActions(BuildContext context) => null;

  @override
  List<Widget> columnItems(BuildContext context) {
    return [
      Expanded(
          flex: 7,
          child: AppsTilesGrid(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            apps: SystemAppController.systemApps,
            customGenerationOption:
                TileGeneratorOption(focusScope: currentScope, context: context),
            scrollDirection: Axis.vertical,
          ))
    ];
  }
}
