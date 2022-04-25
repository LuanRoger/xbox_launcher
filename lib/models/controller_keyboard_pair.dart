import 'package:flutter/material.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class ControllerKeyboardPair {
  LogicalKeySet keyboardkey;
  ControllerButton controllerButton;

  ControllerKeyboardPair(this.keyboardkey, this.controllerButton);
}
