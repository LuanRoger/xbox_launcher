// ignore_for_file: no_logic_in_create_state

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/xinput_controller.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

abstract class XboxPageStateful extends StatefulWidget {
  late XinputController _controller;
  late Map<ShortcutActivator, void Function()> _keyboardBinding;
  Map<ControllerKeyboardPair, void Function(BuildContext context)>? keyAction;

  XboxPageStateful({Key? key, this.keyAction}) : super(key: key);

  void _mapControllerShortcuts(BuildContext context) {
    if (keyAction == null) return;

    _controller = Provider.of<XinputController>(context, listen: false);
    Map<ControllerButton, void Function()> controllerBindings =
        <ControllerButton, void Function()>{};

    keyAction!.forEach((key, value) {
      controllerBindings[key.controllerButton] = (() => value(context));
    });

    _controller.controller.buttonsMapping = controllerBindings;
  }

  void _mapKeyboardShortcuts(BuildContext context) {
    if (keyAction == null) return;

    Map<ShortcutActivator, void Function()> binding =
        <ShortcutActivator, void Function()>{};

    keyAction!.forEach((key, value) {
      binding[SingleActivator(key.keyboardkey)] = (() => value(context));
    });

    _keyboardBinding = binding;
  }

  State<StatefulWidget> vitualCreateState();

  @override
  State<StatefulWidget> createState() => vitualCreateState();
}

abstract class XboxPageState<T extends XboxPageStateful> extends State<T> {
  Widget virtualBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    widget._mapControllerShortcuts(context);
    widget._mapKeyboardShortcuts(context);

    return widget.keyAction != null
        ? CallbackShortcuts(
            bindings: widget._keyboardBinding, child: virtualBuild(context))
        : virtualBuild(context);
  }
}
