import 'package:fluent_ui/fluent_ui.dart';
import 'package:fluent_ui/generated/l10n.dart';
import 'package:flutter/services.dart';
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
      keyboarMapping[SingleActivator(action.key.keyboardkey)] =
          () => action.value(context);
      controllerMapping[action.key.controllerButton] =
          () => action.value(context);
    }
    keyboardProvider.keyboardBinding = keyboarMapping;
    controllerProvider.controller0Binding = controllerMapping;
  }

  static void mapKeyboardActions(BuildContext context,
      Map<LogicalKeyboardKey, void Function(BuildContext context)> keyAction) {
    if (keyAction.isEmpty) return;

    var keyboardProvider =
        Provider.of<KeyboardActionProvider>(context, listen: false);
    keyAction.forEach((key, value) {
      keyboardProvider.keyboardBinding[SingleActivator(key)] =
          () => value(context);
    });
  }

  static void mapControllerActions(BuildContext context,
      Map<ControllerButton, void Function(BuildContext context)> buttonAction) {
    if (buttonAction.isEmpty) return;
    var controllerProvider =
        Provider.of<ControllerActionProvider>(context, listen: false);
    Map<ControllerButton, void Function()> controllerMapping = {};
    buttonAction.forEach((key, value) {
      controllerMapping[key] = () => value;
    });
    controllerProvider.controller0Binding = controllerMapping;
  }

  static void saveAllDefaults(BuildContext context) {
    var keyboardProvider =
        Provider.of<KeyboardActionProvider>(context, listen: false)
            .setCurrentAsDefault();
    var controllerProvider =
        Provider.of<ControllerActionProvider>(context, listen: false)
            .setCurrentAsDefault();
  }

  static void restoreAllDefaults(BuildContext context) {
    var keyboardProvider =
        Provider.of<KeyboardActionProvider>(context, listen: false)
            .restoreDefault();
    var controllerProvider =
        Provider.of<ControllerActionProvider>(context, listen: false)
            .restoreDefault();
  }
}
