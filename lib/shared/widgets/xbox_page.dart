// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/keyboard_controller_action_manipulator.dart';
import 'package:xbox_launcher/models/mapping_definition.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_info.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/providers/keyboard_action_provider.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/hooks/keyboard_controller_mapping_hook.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_scope.dart';
import 'package:xbox_launcher/shared/widgets/focus/focusable_scope.dart';
import 'package:xbox_launcher/shared/widgets/shortcuts/shortcuts_viewer.dart';

abstract class XboxPage extends HookWidget
    implements MappingDefinition, FocusableScope {
  @override
  ElementFocusScope elementsFocusScope = ElementFocusScope();

  ShortcutsViewer? _shortcutsOverlay;

  XboxPage({super.key});

  Widget virtualBuild(BuildContext context);

  void startShortcuts(List<ShortcutInfo> shortcuts, BuildContext context) {
    useKeyMapping(shortcuts.whereType<ShortcutOption>().toList(), context,
        notify: false);
    _shortcutsOverlay = ShortcutsViewer(shortcuts);
  }

  void updateShortcuts(List<ShortcutInfo> shortcuts, BuildContext context) {
    KeyboardControllerActionManipulator.updateCurrentMapping(
        context, shortcuts.whereType<ShortcutOption>().toList());
    _shortcutsOverlay = ShortcutsViewer(shortcuts);
  }

  Widget genPageChild(BuildContext context) {
    if (_shortcutsOverlay != null)
      return Stack(children: [
        Container(color: AppColors.DARK_BG, child: virtualBuild(context)),
        _shortcutsOverlay!
      ]);

    return Container(color: AppColors.DARK_BG, child: virtualBuild(context));
  }

  @override
  Widget build(BuildContext context) {
    List<ShortcutInfo>? mapping = defineMapping(context);

    if (mapping != null) startShortcuts(mapping, context);

    //TODO: Watch [KeyboardActionProvider] with Riverpod
    return CallbackShortcuts(
        bindings: context.read<KeyboardActionProvider>().keyboardBindings,
        child: genPageChild(context));
  }
}
