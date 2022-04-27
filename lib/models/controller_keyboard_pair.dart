import 'package:flutter/services.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class ControllerKeyboardPair {
  LogicalKeyboardKey keyboardkey;
  ControllerButton controllerButton;

  ControllerKeyboardPair(this.keyboardkey, this.controllerButton);
}
