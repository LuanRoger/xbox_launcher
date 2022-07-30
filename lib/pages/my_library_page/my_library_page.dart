import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:xbox_launcher/controllers/keyboard_controller_action_manipulator.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/pages/my_library_page/sections/full_library_section.dart';
import 'package:xbox_launcher/pages/my_library_page/sections/my_apps_section.dart';
import 'package:xbox_launcher/pages/my_library_page/sections/my_external_games_section.dart';
import 'package:xbox_launcher/pages/my_library_page/sections/my_games_section.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateful.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_bar.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_item.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class MyLibraryPage extends XboxPageStateful {
  MyLibraryPage({Key? key})
      : super(pageKeysAction: {
          ControllerKeyboardPair(
              const SingleActivator(LogicalKeyboardKey.escape),
              ControllerButton.B_BUTTON): ((context) => Navigator.pop(context))
        }, key: key);

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
  void defineMapping(BuildContext context) {
    KeyboardControllerActionManipulator.mapKeyboardControllerActions(
        context, widget.pageKeysAction!);
  }

  @override
  Widget virtualBuild(BuildContext context) {
    return NavigationBar(icon: FluentIcons.library, paneItems: [
      NavigationItem("Games"),
      NavigationItem("External games"),
      NavigationItem("Apps"),
      NavigationSeparatorItem(),
      NavigationItem("Full library")
    ], bodyItems: [
      MyGamesSection(),
      MyExternalGamesSection(),
      MyAppsSection(),
      FullLibrarySection()
    ]);
  }
}
