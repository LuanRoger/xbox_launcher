import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/pages/models/xbox_page_stateful.dart';
import 'package:xbox_launcher/pages/my_games_page/sections/all_games_section.dart';

class MyGamesPage extends XboxPageStateful {
  MyGamesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> vitualCreateState() => _MyGamesPageState();
}

class _MyGamesPageState extends State<MyGamesPage> {
  late int selectedTab;

  @override
  void initState() {
    super.initState();
    selectedTab = 0;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
          selected: selectedTab,
          displayMode: PaneDisplayMode.open,
          items: [
            PaneItem(
                title: const Text("Games"), icon: const Icon(FluentIcons.game)),
            PaneItem(
                title: const Text("Apps"),
                icon: const Icon(FluentIcons.app_icon_default))
          ],
          onChanged: (newIndexTab) =>
              setState(() => selectedTab = newIndexTab)),
      content: NavigationBody(
        index: selectedTab,
        children: [AllGamesSection()],
      ),
    );
  }
}
