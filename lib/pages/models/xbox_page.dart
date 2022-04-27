import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/xinput_controller.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class VoidActionIntent extends Intent {}

abstract class XboxPage extends StatelessWidget {
  late XinputController _controller;
  late Map<ShortcutActivator, void Function()> _keyboardBinding;
  Map<ControllerKeyboardPair, VoidCallback>? keyAction;

  XboxPage({Key? key, this.keyAction}) : super(key: key) {
    _mapKeyboardShortcuts();
  }

  void _mapControllerShortcuts(BuildContext context) {
    if (keyAction == null) return;

    _controller = Provider.of<XinputController>(context, listen: false);
    Map<ControllerButton, void Function()> controllerBindings =
        <ControllerButton, void Function()>{};

    keyAction!.forEach((key, value) {
      controllerBindings[key.controllerButton] = value;
    });

    _controller.controller.buttonsMapping = controllerBindings;
  }

  void _mapKeyboardShortcuts() {
    if (keyAction == null) return;

    Map<ShortcutActivator, void Function()> binding =
        <ShortcutActivator, void Function()>{};

    keyAction!.forEach((key, value) {
      binding[SingleActivator(key.keyboardkey)] = value;
    });

    _keyboardBinding = binding;
  }

  Widget virtualBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    _mapControllerShortcuts(context);
    return keyAction != null
        ? CallbackShortcuts(
            bindings: _keyboardBinding, child: virtualBuild(context))
        : virtualBuild(context);
  }
}
