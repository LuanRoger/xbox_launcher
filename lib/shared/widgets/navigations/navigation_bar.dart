import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/widgets/infos_provider/navigation_bar_profile_info.dart';
import 'package:xbox_launcher/shared/widgets/navigations/models/navigation_base.dart';

class NavigationBar extends StatefulWidget implements NavigationBase {
  @override
  final int selectedTab;
  final IconData icon;
  @override
  final List<PaneItem> paneItems;

  const NavigationBar(
      {Key? key,
      this.selectedTab = 0,
      required this.icon,
      required this.paneItems})
      : super(key: key);

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  late int selectedTab;
  late final List<NavigationPaneItem> paneItems;

  @override
  void initState() {
    super.initState();

    selectedTab = widget.selectedTab;
    paneItems = List.from(widget.paneItems);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      contentShape:
          const ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
      clipBehavior: Clip.antiAlias,
      pane: NavigationPane(
          header: NavigationBarProfile(widget.icon),
          selected: selectedTab,
          indicator: StickyNavigationIndicator(
            color: context.read<ProfileProvider>().accentColor,
          ),
          size: const NavigationPaneSize(headerHeight: 140),
          displayMode: PaneDisplayMode.open,
          onChanged: (index) => setState(() => selectedTab = index),
          items: paneItems),
      transitionBuilder: (child, animation) =>
          EntrancePageTransition(child: child, animation: animation),
    );
  }
}
