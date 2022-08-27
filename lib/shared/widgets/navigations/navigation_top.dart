import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/widgets/navigations/models/navigation_base.dart';

class NavigationTop extends StatefulWidget implements NavigationBase {
  @override
  final int selectedTab;
  @override
  final List<Widget> bodyItems;
  @override
  final List<NavigationPaneItem> paneItems;

  const NavigationTop(
      {Key? key,
      this.selectedTab = 0,
      required this.bodyItems,
      required this.paneItems})
      : super(key: key);

  @override
  State<NavigationTop> createState() => _NavigationTopState();
}

class _NavigationTopState extends State<NavigationTop> {
  late int selectedTab;

  @override
  void initState() {
    super.initState();
    selectedTab = widget.selectedTab;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
          selected: selectedTab,
          displayMode: PaneDisplayMode.top,
          indicator: StickyNavigationIndicator(
              color: context.read<ProfileProvider>().accentColor),
          size: const NavigationPaneSize(topHeight: 70),
          onChanged: (newIndex) => setState(() => selectedTab = newIndex),
          items: widget.paneItems),
      content: NavigationBody(
        index: selectedTab,
        children: widget.bodyItems,
      ),
    );
  }
}
