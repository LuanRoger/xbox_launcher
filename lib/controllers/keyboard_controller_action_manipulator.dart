import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/providers/controller_action_provider.dart';
import 'package:xbox_launcher/providers/keyboard_action_provider.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

//TODO: Create global fucntions for manipulate this class.
// If you are in a build context, use the hooks.

//TODO: Made this private.
class KeyboardControllerActionManipulator {
  static void mapKeyboardControllerActions(
      BuildContext context, List<ShortcutOption> shortcutsOptions,
      {bool notify = true}) {
    if (shortcutsOptions.isEmpty) return;

    Map<ShortcutActivator, void Function()> keyboarMapping = {};
    Map<ControllerButton, void Function()> controllerMapping = {};
    for (var action in shortcutsOptions
        .map((shortcutOption) => shortcutOption.rawShortcut)) {
      keyboarMapping[action.key.keyboardkey] = () => action.value(context);
      controllerMapping[action.key.controllerButton] =
          () => action.value(context);
    }

    context
        .read<KeyboardActionProvider>()
        .setKeyboardBinding(keyboarMapping, notify: notify);
    context
        .read<ControllerActionProvider>()
        .setControllerBinding(controllerMapping);
  }

  static void updateCurrentMapping(
      BuildContext context, List<ShortcutOption> shortcutsOptions,
      {bool notify = true}) {
    if (shortcutsOptions.isEmpty) return;

    Map<ShortcutActivator, void Function()> keyboarMapping = {};
    Map<ControllerButton, void Function()> controllerMapping = {};
    for (var action in shortcutsOptions
        .map((shortcutOption) => shortcutOption.rawShortcut)) {
      keyboarMapping[action.key.keyboardkey] = () => action.value(context);
      controllerMapping[action.key.controllerButton] =
          () => action.value(context);
    }

    context
        .read<KeyboardActionProvider>()
        .updateKeyboardBinding(keyboarMapping, notify: notify);
    context
        .read<ControllerActionProvider>()
        .updateControllerBinding(controllerMapping);
  }

  static void applyMementoInAll(BuildContext context) {
    context.read<KeyboardActionProvider>().applyFromMementoStack();
    context.read<ControllerActionProvider>().applyFromMementoStack();
  }
}
