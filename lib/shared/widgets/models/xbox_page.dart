// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/controllers/controller_action_manipulator.dart';
import 'package:xbox_launcher/models/mapping_definition.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_info.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_scope.dart';
import 'package:xbox_launcher/shared/widgets/focus/focable_element.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_builder.dart';
import 'package:xbox_launcher/shared/widgets/shortcuts/shortcut_viewer_support.dart';

abstract class XboxPage extends StatefulWidget {
  const XboxPage({Key? key}) : super(key: key);
}

abstract class XboxPageState<T extends XboxPage> extends State<T>
    with ShortcutViewerSupport
    implements MappingDefinition, XboxPageBuilder {
  ElementFocusScope elementFocusScope = ElementFocusScope();

  XboxPageState() {
    elementFocusScope.onElementFocus = onElementFocus;
  }

  List<ShortcutInfo>? cachedShortcutsInfo;
  Map<ShortcutActivator, void Function()> get shortcutsBindings {
    if (cachedShortcutsInfo == null) return {};

    List<ShortcutOption> shortcutsOption =
        cachedShortcutsInfo!.whereType<ShortcutOption>().toList();
    return Map.fromEntries(shortcutsOption.map((e) => e.rawShortcutCallback));
  }

  @override
  void initState() {
    super.initState();

    cachedShortcutsInfo = defineMapping(context);
    if (cachedShortcutsInfo != null) _addPageShortcuts(cachedShortcutsInfo!);
  }

  @override
  void deactivate() {
    ControllerActionManipulator.applyMementoInAll(context);
    super.deactivate();
  }

  Widget virtualBuild(BuildContext context);
  void onElementFocus(FocableElement sender, Object? focusedElementValue) {
    /*Virtual: Not required*/
  }

  void updateShortcuts(List<ShortcutInfo> shortcuts) {
    ControllerActionManipulator.mapControllerActions(
        context, shortcuts.whereType<ShortcutOption>().toList(), false);
    updateShortcutsViewer(shortcuts);

    cachedShortcutsInfo = List.from(shortcuts);
  }

  void _addPageShortcuts(List<ShortcutInfo> shortcuts) {
    ControllerActionManipulator.mapControllerActions(
        context, shortcuts.whereType<ShortcutOption>().toList(), true);
    updateShortcutsViewer(shortcuts);

    cachedShortcutsInfo = List.from(shortcuts);
  }

  @override
  Widget genPageChild(BuildContext context) {
    if (supportShortcuts)
      return Stack(children: [
        Container(color: AppColors.DARK_BG, child: virtualBuild(context)),
        shortcutOverlayWidget!
      ]);
    else
      return Container(color: AppColors.DARK_BG, child: virtualBuild(context));
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
        bindings: shortcutsBindings, child: genPageChild(context));
  }
}
