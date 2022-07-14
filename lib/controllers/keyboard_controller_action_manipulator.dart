import 'package:fluent_ui/fluent_ui.dart';
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
    var keyboardProvider =
        Provider.of<KeyboardActionProvider>(context, listen: false);
    var controllerProvider =
        Provider.of<ControllerActionProvider>(context, listen: false);

    for (var action in actionEntry.entries) {
      keyboardProvider
              .keyboardBinding[SingleActivator(action.key.keyboardkey)] =
          () => action.value(context);
      controllerProvider.setMappingToAll(
          MapEntry(action.key.controllerButton, () => action.value(context)));
    }
  }

  static void mapKeyboardActions(BuildContext context,
      Map<LogicalKeyboardKey, void Function(BuildContext context)> keyAction) {
    var keyboardProvider =
        Provider.of<KeyboardActionProvider>(context, listen: false);
    keyAction.forEach((key, value) {
      keyboardProvider.keyboardBinding[SingleActivator(key)] =
          () => value(context);
    });
  }

  static void mapControllerActions(BuildContext context,
      Map<ControllerButton, void Function(BuildContext context)> buttonAction) {
    var controllerProvider =
        Provider.of<ControllerActionProvider>(context, listen: false);
    buttonAction.forEach((key, value) {
      controllerProvider.setMappingToAll(MapEntry(key, () => value(context)));
    });
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
