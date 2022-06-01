import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/providers/theme_data_profile.dart';
import 'package:xbox_launcher/shared/widgets/models/navigation_item.dart';
import 'package:xbox_launcher/shared/widgets/navigation_bar_profile_info.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/widget_gen.dart';

class NavigationBar extends StatefulWidget {
  int selectedTab;
  IconData icon;
  List<NavigationItem> paneItems;
  List<Widget> bodyItems;

  NavigationBar(
      {Key? key,
      this.selectedTab = 0,
      required this.icon,
      required this.paneItems,
      required this.bodyItems})
      : super(key: key);

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  late int selectedTab;

  @override
  void initState() {
    super.initState();

    selectedTab = widget.selectedTab;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(),
      pane: NavigationPane(
          header: NavigationBarProfile(widget.icon),
          selected: selectedTab,
          indicator: StickyNavigationIndicator(
            color: Provider.of<ProfileProvider>(context, listen: false)
                .accentColor,
          ),
          displayMode: PaneDisplayMode.open,
          onChanged: (index) => setState(() => selectedTab = index),
          items: WidgetGen.generatePaneItems(widget.paneItems)),
      content: NavigationBody(index: selectedTab, children: widget.bodyItems),
    );
  }
}
