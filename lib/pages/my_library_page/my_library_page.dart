// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/pages/my_library_page/sections/apps_group_section.dart';
import 'package:xbox_launcher/pages/my_library_page/sections/full_library_section.dart';
import 'package:xbox_launcher/pages/my_library_page/sections/manage_section.dart';
import 'package:xbox_launcher/pages/my_library_page/sections/my_apps_section.dart';
import 'package:xbox_launcher/pages/my_library_page/sections/my_games_section.dart';
import 'package:xbox_launcher/shared/widgets/buttons/text_button.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu_add_group.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu_item.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/system_dialog.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateful.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_bar.dart';
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
  List<ShortcutOption>? defineMapping(BuildContext context) => [
        ShortcutOption("Back",
            controllerKeyboardPair: ControllerKeyboardPair(
                const SingleActivator(LogicalKeyboardKey.escape),
                ControllerButton.B_BUTTON),
            action: (context) => Navigator.pop(context)),
      ];

  @override
  Widget virtualBuild(BuildContext context) {
    return NavigationBar(
      icon: FluentIcons.library,
      paneItems: [
        PaneItem(
            icon: const Icon(FluentIcons.history), title: const Text("Games")),
        PaneItem(
            icon: const Icon(FluentIcons.app_icon_default),
            title: const Text("Apps")),
        PaneItem(
            icon: const Icon(FluentIcons.favorite_list),
            title: const Text("Group")),
        PaneItem(
            icon: const Icon(FluentIcons.library),
            title: const Text("Full library")),
        PaneItemSeparator(),
        PaneItem(
            icon: const Icon(FluentIcons.toolbox), title: const Text("Manage"))
      ],
      bodyItems: [
        MyGamesSection(),
        const MyAppsSection(),
        const AppsGroupSection(),
        FullLibrarySection(),
        const ManageSection()
      ],
    );
  }
}
