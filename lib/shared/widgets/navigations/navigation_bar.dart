import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/widgets/infos_provider/navigation_bar_profile_info.dart';
import 'package:xbox_launcher/shared/widgets/navigations/models/navigation_base.dart';

class NavigationBar extends HookWidget implements NavigationBase {
  @override
  final int selectedTab;
  final IconData icon;
  @override
  final List<NavigationPaneItem> paneItems;

  const NavigationBar(
      {Key? key,
      this.selectedTab = 0,
      required this.icon,
      required this.paneItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTabState = useState<int>(selectedTab);

    return NavigationView(
      contentShape:
          const ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
      clipBehavior: Clip.antiAlias,
      pane: NavigationPane(
          header: NavigationBarProfile(icon),
          selected: selectedTabState.value,
          indicator: StickyNavigationIndicator(
            color: context.read<ProfileProvider>().accentColor,
          ),
          size: const NavigationPaneSize(headerHeight: 140),
          displayMode: PaneDisplayMode.open,
          onChanged: (newIndex) {
            selectedTabState.value = newIndex;
          },
          items: paneItems),
      transitionBuilder: (child, animation) =>
          EntrancePageTransition(child: child, animation: animation),
    );
  }
}
