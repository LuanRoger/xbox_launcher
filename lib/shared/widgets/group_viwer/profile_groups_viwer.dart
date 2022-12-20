import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_scope.dart';
import 'package:xbox_launcher/shared/widgets/group_viwer/group_viwer.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';

class ProfileGroupsViewer extends StatelessWidget {
  final ElementFocusScope elementFocusScope;

  const ProfileGroupsViewer({super.key, required this.elementFocusScope});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 20,
      child: Consumer<ProfileProvider>(
        builder: (context, value, __) => ListView(
          children: value.appsGroups
              .map((group) => Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: GroupViwer(
                    group,
                    tileGeneratorOption: TileGeneratorOption(
                      focusScope: elementFocusScope,
                      context: context,
                    ),
                  )))
              .toList(),
        ),
      ),
    );
  }
}
