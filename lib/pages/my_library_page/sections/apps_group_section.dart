import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/apps_group.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/widgets/group_viwer.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section_stateless.dart';

class AppsGroupSection extends NavigationSectionStateless {
  const AppsGroupSection({super.key}) : super("Groups");

  @override
  List<Widget>? titleActions(BuildContext context) => null;

  @override
  List<Widget> columnItems(BuildContext context) {
    return [
      Selector<ProfileProvider, List<AppsGroup>>(
          selector: (_, profileProvider) => profileProvider.appsGroups,
          builder: (_, value, __) {
            if (value.isEmpty) return const Text("Não há grupos");

            return Column(
              children: value.map((group) => GroupViwer(group.id!)).toList(),
            );
          })
    ];
  }
}
