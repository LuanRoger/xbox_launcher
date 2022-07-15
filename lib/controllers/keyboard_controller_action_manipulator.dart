import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/providers/controller_action_provider.dart';
import 'package:xbox_launcher/providers/keyboard_action_provider.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class KeyboardControllerActionManipulator {
  static void mapKeyboardControllerActions(
      BuildContext context,
      Map<ControllerKeyboardPair, void Function(BuildContext context)>
          actionEntry) {
    if (actionEntry.isEmpty) return;

    var keyboardProvider =
        Provider.of<KeyboardActionProvider>(context, listen: false);
    var controllerProvider =
        Provider.of<ControllerActionProvider>(context, listen: false);

    Map<ShortcutActivator, void Function()> keyboarMapping = {};
    Map<ControllerButton, void Function()> controllerMapping = {};
    for (var action in actionEntry.entries) {
      keyboarMapping[action.key.keyboardkey] = () => action.value(context);
      controllerMapping[action.key.controllerButton] =
          () => action.value(context);
    }
    keyboardProvider.keyboardBinding = keyboarMapping;
    controllerProvider.controller0Binding = controllerMapping;
  }

  static void mapKeyboardActions(BuildContext context,
      Map<SingleActivator, void Function(BuildContext context)> keyAction) {
    if (keyAction.isEmpty) return;

    var keyboardProvider =
        Provider.of<KeyboardActionProvider>(context, listen: false);
    Map<ShortcutActivator, void Function()> keyboardMapping = {};
    keyAction.forEach((key, value) {
      keyboardMapping[key] = () => value(context);
    });

    keyboardProvider.keyboardBinding = keyboardMapping;
  }

  static void mapControllerActions(BuildContext context,
      Map<ControllerButton, void Function(BuildContext context)> buttonAction) {
    if (buttonAction.isEmpty) return;
    var controllerProvider =
        Provider.of<ControllerActionProvider>(context, listen: false);
    Map<ControllerButton, void Function()> controllerMapping = {};
    buttonAction.forEach((key, value) {
      controllerMapping[key] = () => value(context);
    });
    controllerProvider.controller0Binding = controllerMapping;
  }

  static void saveAllCurrentAtMemento(BuildContext context) {
    Provider.of<KeyboardActionProvider>(context, listen: false)
        .addToMementoStack();
    Provider.of<ControllerActionProvider>(context, listen: false)
        .addToMementoStack();
  }

  static void applyMementoInAll(BuildContext context) {
    Provider.of<KeyboardActionProvider>(context, listen: false)
        .applyFromMementoStack();
    Provider.of<ControllerActionProvider>(context, listen: false)
        .applyFromMementoStack();
  }
}
