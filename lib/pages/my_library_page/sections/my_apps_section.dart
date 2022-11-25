import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/system_app_controller.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section_stateless.dart';
import 'package:xbox_launcher/shared/widgets/tiles/apps_tiles_grid.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/widget_gen.dart';

class MyAppsSection extends NavigationSectionStateless {
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
            scrollDirection: Axis.vertical,
          ))
    ];
  }
}
