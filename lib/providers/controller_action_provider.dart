import 'package:xbox_launcher/controllers/xinput_controller.dart';
import 'package:xbox_launcher/models/memento.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class ControllerActionProvider
    implements Memento<Map<ControllerButton, Function>> {
  @override
  List<Map<ControllerButton, Function>> mementoStack =
      List.empty(growable: true);
  final XInputController _inputController;

  Map<ControllerButton, Function> get controller0Binding =>
      _inputController.controller0.buttonsMapping!;
  set controller0Binding(Map<ControllerButton, Function> buttonsBinding) {
    _inputController.controller0.buttonsMapping = buttonsBinding;
    _inputController.mapBasicControllers();
  }

  ControllerActionProvider(this._inputController);

  @override
  void addToMementoStack() => mementoStack
      .add(Map<ControllerButton, Function>.from(controller0Binding));

  @override
  void applyFromMementoStack() {
    var valueToApply = mementoStack.removeLast();
    controller0Binding = valueToApply;
  }

  @override
  Map<ControllerButton, Function> removeFromMementoStack() =>
      mementoStack.removeLast();
}
