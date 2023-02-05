import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/system_app_controller.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section_stateless.dart';
import 'package:xbox_launcher/shared/widgets/tiles/apps_tile_grid.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';

class MyAppsSection extends NavigationSectionStateless {
  const MyAppsSection({super.key, required super.currentScope}) : super("Apps");

  @override
  List<Widget>? titleActions(BuildContext context) => null;

  @override
  List<Widget> columnItems(BuildContext context) {
    final TileSize tileSize = context.read<ProfileProvider>().myLibraryTileSize;

    return [
      Expanded(
          flex: 7,
          child: AppsTilesGrid(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            apps: SystemAppController.systemApps,
            customGenerationOption: TileGeneratorOption(
                focusScope: currentScope,
                context: context,
                tilesSize: tileSize),
            scrollDirection: Axis.vertical,
          ))
    ];
  }
}
