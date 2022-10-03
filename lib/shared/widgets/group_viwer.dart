import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:xbox_launcher/models/apps_group.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/buttons/outlined_text_button.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu_group.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_grid.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/widget_gen.dart';

class GroupViwer extends StatelessWidget {
  final AppsGroup group;

  const GroupViwer(this.group, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlinedTextButton(
          title: group.groupName,
          onPressed: () => ContextMenuGroup(group).show(context),
        ),
        const SizedBox(height: 5.0),
        TileGrid.count(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          tiles: WidgetGen.generateByModel(group.apps,
              TileGeneratorOption([TileSize.MEDIUM], context: context)),
        )
      ],
    );
  }
}
