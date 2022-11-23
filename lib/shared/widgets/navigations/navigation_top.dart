import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xbox_launcher/providers/profile_providers.dart';
import 'package:xbox_launcher/shared/widgets/navigations/models/navigation_base.dart';

class NavigationTop extends HookConsumerWidget implements NavigationBase {
  @override
  final int selectedTab;
  @override
  final List<PaneItem> paneItems;

  const NavigationTop({Key? key, this.selectedTab = 0, required this.paneItems})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTabState = useState<int>(selectedTab);

    return NavigationView(
      pane: NavigationPane(
          selected: selectedTab,
          displayMode: PaneDisplayMode.top,
          indicator: StickyNavigationIndicator(
              color: ref.read(profileThemeProvider).accentColor),
          size: const NavigationPaneSize(topHeight: 70),
          onChanged: (newIndex) => selectedTabState.value = newIndex,
          items: paneItems),
    );
  }
}
