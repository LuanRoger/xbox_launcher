import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/widgets/navigation_bar_profile_info.dart';
import 'package:xbox_launcher/shared/widgets/navigations/models/navigation_base.dart';

class NavigationBar extends StatefulWidget implements NavigationBase {
  @override
  final int selectedTab;
  final IconData icon;
  @override
  final List<NavigationPaneItem> paneItems;
  @override
  final List<Widget> bodyItems;

  const NavigationBar(
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
            color: context.read<ProfileProvider>().accentColor,
          ),
          displayMode: PaneDisplayMode.open,
          onChanged: (index) => setState(() => selectedTab = index),
          items: widget.paneItems),
      content: NavigationBody(index: selectedTab, children: widget.bodyItems),
    );
  }
}
