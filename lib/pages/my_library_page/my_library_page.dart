// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fluent_ui/fluent_ui.dart' hide TextButton;
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_info.dart';
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
import 'package:xbox_launcher/shared/widgets/dialogs/external_site_dialog.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/system_dialog.dart';
import 'package:xbox_launcher/shared/widgets/focus/focable_element.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_bar.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class MyLibraryPage extends XboxPage {
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
  void onElementFocus(FocableElement sender, Object? focusedElementValue) {
    List<ShortcutInfo>? shortcutInfo = List.empty(growable: true);

    if (focusedElementValue is AppModel) {
      shortcutInfo.add(
        ShortcutOption(
          "Back",
          controllerKeyboardPair: ControllerKeyboardPair(
              const SingleActivator(LogicalKeyboardKey.escape),
              ControllerButton.B_BUTTON),
          action: () => Navigator.pop(context),
        ),
      );
      if (focusedElementValue is GameModel) {
        shortcutInfo.add(ShortcutOption(
          "More Options",
          controllerKeyboardPair: ControllerKeyboardPair(
              const SingleActivator(LogicalKeyboardKey.f1),
              ControllerButton.BACK),
          action: () => ContextMenu("Options", contextItems: [
            ContextMenuItem("Add to a group",
                icon: FluentIcons.add,
                onPressed: () => ContextMenuAddGroup(focusedElementValue.name,
                        appModel: focusedElementValue)
                    .show(context)),
            ContextMenuItem("See on Microsoft Store",
                icon: FluentIcons.store_logo16,
                onPressed: () async =>
                    ExternalSiteDialog(Uri.parse(focusedElementValue.storeUrl))
                        .show(context)),
          ]).show(context),
        ));
      }
    } else
      shortcutInfo = defineMapping(context);

    if (shortcutInfo == null) return;

    updateShortcuts(shortcutInfo);
  }

  @override
  List<ShortcutOption>? defineMapping(BuildContext context) => [
        ShortcutOption("Back",
            controllerKeyboardPair: ControllerKeyboardPair(
                const SingleActivator(LogicalKeyboardKey.escape),
                ControllerButton.B_BUTTON),
            action: () => Navigator.pop(context)),
      ];

  @override
  Widget virtualBuild(BuildContext context) {
    return NavigationBar(icon: FluentIcons.library, paneItems: [
      PaneItem(
          icon: const Icon(FluentIcons.history),
          title: const Text("Games"),
          body: MyGamesSection(currentScope: elementFocusScope)),
      PaneItem(
          icon: const Icon(FluentIcons.app_icon_default),
          title: const Text("Apps"),
          body: MyAppsSection(currentScope: elementFocusScope)),
      PaneItem(
          icon: const Icon(FluentIcons.favorite_list),
          title: const Text("Group"),
          body: AppsGroupSection(
            currentScope: elementFocusScope,
          )),
      PaneItem(
          icon: const Icon(FluentIcons.library),
          title: const Text("Full library"),
          body: FullLibrarySection(currentScope: elementFocusScope)),
      PaneItem(
          icon: const Icon(FluentIcons.toolbox),
          title: const Text("Manage"),
          body: ManageSection(currentScope: elementFocusScope))
    ]);
    ;
  }
}
