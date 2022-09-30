import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/apps_group.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_grid.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/widget_gen.dart';

class GroupViwer extends StatelessWidget {
  final int groupId;
  const GroupViwer(this.groupId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ProfileProvider, AppsGroup>(
        selector: (_, profileProvider) => profileProvider.appsGroups
            .firstWhere((group) => group.id == groupId),
        builder: ((_, value, __) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value.groupName,
                style: AppTextStyle.APPS_GROUP_TITLE,
              ),
              const SizedBox(height: 5.0),
              TileGrid.count(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                tiles: WidgetGen.generateByModel(value.apps,
                    TileGeneratorOption([TileSize.MEDIUM], context: context)),
              )
            ],
          );
        }));
  }
}
