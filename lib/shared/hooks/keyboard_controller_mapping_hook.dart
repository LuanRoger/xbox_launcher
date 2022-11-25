import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:xbox_launcher/controllers/keyboard_controller_action_manipulator.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';

void useKeyMapping(List<ShortcutOption> shortcuts, BuildContext context,
    {bool notify = true}) {
  use(_KeyboardControllerMappingHook(shortcuts, context, notify: notify));
}

class _KeyboardControllerMappingHook extends Hook<void> {
  final List<ShortcutOption> shortcuts;
  final BuildContext context;
  final notify;

  const _KeyboardControllerMappingHook(this.shortcuts, this.context,
      {this.notify = true});

  @override
  HookState<void, Hook<void>> createState() =>
      _KeyboardControllerMappingHookState();
}

class _KeyboardControllerMappingHookState
    extends HookState<void, _KeyboardControllerMappingHook> {
  @override
  void initHook() {
    super.initHook();
    KeyboardControllerActionManipulator.mapKeyboardControllerActions(
        hook.context, hook.shortcuts, hook.notify);
  }

  @override
  void dispose() {
    super.dispose();
    KeyboardControllerActionManipulator.applyMementoInAll(hook.context);
  }

  @override
  void build(BuildContext context) {}
}
