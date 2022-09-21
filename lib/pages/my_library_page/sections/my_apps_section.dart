import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/controllers/system_app_controller.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section_stateless.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_grid.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/widget_gen.dart';

class MyAppsSection extends NavigationSectionStateless {
  const MyAppsSection({Key? key}) : super("Apps", key: key);

  @override
  List<Widget>? titleActions(BuildContext context) => null;
  @override
  List<Widget>? midActions(BuildContext context) => null;

  @override
  List<Widget> columnItems(BuildContext context) => [
        Expanded(
            flex: 7,
            child: TileGrid.count(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              tiles: WidgetGen.generateByModel(SystemAppController.systemApps,
                  TileGeneratorOption([TileSize.MEDIUM], context: context)),
              scrollDirection: Axis.vertical,
            ))
      ];
}
