import 'package:xbox_launcher/controllers/xinput_controller.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class ControllerActionProvider {
  XInputController _inputController;
  Map<ControllerButton, Function>? _controllersDefaultInput;

  Map<ControllerButton, Function> get controller0Binding =>
      _inputController.controller0.buttonsMapping!;
  set controller0Binding(Map<ControllerButton, Function> buttonsBinding) =>
      _inputController.controller0.buttonsMapping = buttonsBinding;

  ControllerActionProvider(this._inputController);

  void setCurrentAsDefault() {
    _controllersDefaultInput =
        Map<ControllerButton, Function>.from(controller0Binding);
  }

  void restoreDefault() {
    _inputController.controller0.buttonsMapping = _controllersDefaultInput;
    _controllersDefaultInput = null;
  }
}
