import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:xbox_launcher/models/apps_group.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_outlined_button.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu_group.dart';
import 'package:xbox_launcher/shared/widgets/tiles/apps_tile_grid.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_grid.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/widget_gen.dart';

class GroupViwer extends StatelessWidget {
  final AppsGroup group;
  final SliverGridDelegate? appsGridDelegate;
  final TileGeneratorOption tileGeneratorOption;
  final bool buttonEnable;

  const GroupViwer(this.group,
      {super.key,
      this.appsGridDelegate,
      required this.tileGeneratorOption,
      this.buttonEnable = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextOutlinedButton(
          title: group.groupName,
          height: null,
          onPressed: () =>
              buttonEnable ? ContextMenuGroup(group).show(context) : null,
        ),
        const SizedBox(height: 5.0),
        AppsTilesGrid(
          apps: group.apps,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          customGenerationOption: tileGeneratorOption,
        )
      ],
    );
  }
}
