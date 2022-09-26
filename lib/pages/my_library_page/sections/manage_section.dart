import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_section_stateless.dart';

class ManageSection extends NavigationSectionStateless {
  const ManageSection({super.key}) : super("Manage");

  @override
  List<Widget>? titleActions(BuildContext context) => null;

  @override
  List<Widget> columnItems(BuildContext context) {
    return [const Text("Not done yet.")];
  }
}
