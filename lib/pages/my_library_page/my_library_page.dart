import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/pages/my_library_page/sections/full_library_section.dart';
import 'package:xbox_launcher/pages/my_library_page/sections/my_apps_section.dart';
import 'package:xbox_launcher/pages/my_library_page/sections/my_games_section.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateful.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_bar.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_item.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class MyLibraryPage extends XboxPageStateful {
  const MyLibraryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyGamesPageState();
}

class _MyGamesPageState extends XboxPageState<MyLibraryPage> {
  late int selectedTab;

  @override
  void initState() {
    super.initState();
    selectedTab = 0;
  }

  @override
  Map<ControllerKeyboardPair, void Function(BuildContext)>? defineMapping(
          BuildContext context) =>
      {
        ControllerKeyboardPair(const SingleActivator(LogicalKeyboardKey.escape),
            ControllerButton.B_BUTTON): ((context) => Navigator.pop(context))
      };

  @override
  Widget virtualBuild(BuildContext context) {
    return NavigationBar(icon: FluentIcons.library, paneItems: [
      NavigationItem("Games"),
      NavigationItem("Apps"),
      NavigationSeparatorItem(),
      NavigationItem("Full library")
    ], bodyItems: [
      MyGamesSection(),
      const MyAppsSection(),
      FullLibrarySection()
    ]);
  }
}
