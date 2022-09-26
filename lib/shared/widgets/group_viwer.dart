import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_grid.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/widget_gen.dart';

class GroupViwer extends StatelessWidget {
  final int groupId;
  const GroupViwer(this.groupId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: ((_, value, __) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value.appsGroups[groupId].groupName),
          TileGrid.count(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            tiles: WidgetGen.generateByModel(value.appsGroups[groupId].apps,
                TileGeneratorOption([TileSize.MEDIUM], context: context)),
          )
        ],
      );
    }));
  }
}
