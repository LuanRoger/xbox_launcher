// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xbox_launcher/controllers/keyboard_controller_action_manipulator.dart';
import 'package:xbox_launcher/models/mapping_definition.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_info.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/providers/controllers_providers.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/hooks/keyboard_controller_mapping_hook.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_scope.dart';
import 'package:xbox_launcher/shared/widgets/focus/focusable_scope.dart';
import 'package:xbox_launcher/shared/widgets/shortcuts/shortcuts_viewer.dart';

abstract class XboxPage extends HookConsumerWidget
    implements MappingDefinition, FocusableScope {
  @override
  ElementFocusScope elementsFocusScope = ElementFocusScope();
  ShortcutsViewer? _shortcutsOverlay;

  XboxPage({super.key});

  Widget virtualBuild(BuildContext context, WidgetRef ref);

  void startShortcuts(List<ShortcutInfo> shortcuts, WidgetRef ref) {
    useKeyMapping(ref, shortcuts.whereType<ShortcutOption>().toList(),
        notify: false);
    _shortcutsOverlay = ShortcutsViewer(shortcuts);
  }

  void updateShortcuts(
      WidgetRef ref, BuildContext context, List<ShortcutInfo> shortcuts) {
    KeyboardControllerActionManipulator.updateCurrentMapping(
        ref, context, shortcuts.whereType<ShortcutOption>().toList(), false);
    _shortcutsOverlay = ShortcutsViewer(shortcuts);
  }

  Widget genPageChild(BuildContext context, WidgetRef ref) {
    if (_shortcutsOverlay != null)
      return Stack(children: [
        Container(color: AppColors.DARK_BG, child: virtualBuild(context, ref)),
        _shortcutsOverlay!
      ]);

    return Container(
        color: AppColors.DARK_BG, child: virtualBuild(context, ref));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyboardShortcutsMapping = ref.watch(keyboardActionProvider);
    List<ShortcutInfo>? mapping = defineMapping(context);

    if (mapping != null) startShortcuts(mapping, ref);

    return CallbackShortcuts(
        bindings: keyboardShortcutsMapping.state,
        child: genPageChild(useContext(), ref));
  }
}
