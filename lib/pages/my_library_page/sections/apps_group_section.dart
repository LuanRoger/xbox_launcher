import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/widgets/group_viwer/group_viwer.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section_stateless.dart';
import 'package:xbox_launcher/shared/widgets/placeholder_messages/no_groups_message.dart';

class AppsGroupSection extends NavigationSectionStateless {
  const AppsGroupSection({super.key}) : super("Groups");

  @override
  List<Widget>? titleActions(BuildContext context) => null;

  @override
  List<Widget> columnItems(BuildContext context) {
    return [
      Consumer<ProfileProvider>(builder: (_, value, __) {
        if (value.appsGroups.isEmpty) return const NoGroupsMessage();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: value.appsGroups
              .map((group) => Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: GroupViwer(group)))
              .toList(),
        );
      })
    ];
  }
}
