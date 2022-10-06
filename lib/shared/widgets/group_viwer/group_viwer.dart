import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:xbox_launcher/models/apps_group.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/buttons/outlined_text_button.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu_group.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_grid.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/widget_gen.dart';

class GroupViwer extends StatelessWidget {
  final AppsGroup group;
  final SliverGridDelegate? appsGridDelegate;
  final TileGeneratorOption? tileGeneratorOption;
  final bool buttonEnable;

  const GroupViwer(this.group,
      {super.key,
      this.appsGridDelegate,
      this.tileGeneratorOption,
      this.buttonEnable = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlinedTextButton(
          title: group.groupName,
          onPressed: () =>
              buttonEnable ? ContextMenuGroup(group).show(context) : null,
        ),
        const SizedBox(height: 5.0),
        TileGrid.count(
          gridDelegate: appsGridDelegate ??
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
          tiles: WidgetGen.generateByModel(
              group.apps,
              tileGeneratorOption ??
                  TileGeneratorOption([TileSize.MEDIUM], context: context)),
        )
      ],
    );
  }
}
