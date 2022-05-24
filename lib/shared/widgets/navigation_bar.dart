import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/theme_data_provider.dart';
import 'package:xbox_launcher/shared/widgets/models/navigation_item.dart';
import 'package:xbox_launcher/shared/widgets/navigation_bar_profile_info.dart';

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

  //TODO: Create generators
  List<NavigationPaneItem> _generateItems() {
    List<NavigationPaneItem> barItems = List.empty(growable: true);
    for (NavigationItem item in widget.paneItems) {
      barItems.add(PaneItem(icon: const SizedBox(), title: Text(item.text)));
    }

    return barItems;
  }

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
            color: Provider.of<ThemeDataProvider>(context, listen: false)
                .accentColor,
          ),
          displayMode: PaneDisplayMode.open,
          onChanged: (index) => setState(() => selectedTab = index),
          items: _generateItems()),
      content: NavigationBody(index: selectedTab, children: widget.bodyItems),
    );
  }
}
