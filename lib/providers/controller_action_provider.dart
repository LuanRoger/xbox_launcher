import 'package:xbox_launcher/controllers/xinput_controller.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class ControllerActionProvider {
  XInputController _inputController;
  Map<ControllerButton, Function>? _controllersDefaultInput;
  Map<ControllerButton, Function> get controller0Bindings =>
      _inputController.controller0.buttonsMapping!;

  ControllerActionProvider(this._inputController);

  void setMappingToAll(MapEntry<ControllerButton, Function> mapping) {
    _inputController.controller0.buttonsMapping?[mapping.key] = mapping.value;
  }

  void setCurrentAsDefault() {
    _controllersDefaultInput =
        Map<ControllerButton, Function>.from(controller0Bindings);
  }

  void restoreDefault() {
    _inputController.controller0.buttonsMapping = _controllersDefaultInput;
    _controllersDefaultInput = null;
  }
}
