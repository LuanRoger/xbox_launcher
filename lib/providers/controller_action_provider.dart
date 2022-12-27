import 'package:xbox_launcher/controllers/xinput_controller.dart';
import 'package:xbox_launcher/models/memento.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class ControllerActionProvider
    implements Memento<Map<ControllerButton, Function>> {
  @override
  List<Map<ControllerButton, Function>> mementoStack =
      List.empty(growable: true);
  final XInputController _inputController;

  ControllerActionProvider(this._inputController);

  void setControllerMapping(
      Map<ControllerButton, void Function()> controllerMapping) {
    _inputController.controller0.buttonsMapping = controllerMapping;
    _inputController.mapBasicControllers();

    addToMementoStack();
  }

  void popLastKeyboardBindig() {
    applyFromMementoStack();
  }

  @override
  void addToMementoStack() =>
      mementoStack.add(Map<ControllerButton, Function>.from(
          _inputController.controller0.buttonsMapping!));

  @override
  void applyFromMementoStack() {
    Map<ControllerButton, Function>? valueToApply = mementoStack.removeLast();
    if (mementoStack.isEmpty) valueToApply = null;

    _inputController.controller0.buttonsMapping = valueToApply;
  }

  @override
  Map<ControllerButton, Function> removeFromMementoStack() =>
      mementoStack.removeLast();
}
