import 'package:virtual_keyboard/virtual_keyboard.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class XInputController {
  late Controller controller0;
  //Not supported yet
  late Controller controller1;
  late Controller controller2;
  late Controller controller3;
  late Controller controller4;

  Keyboard keyboardControllerInputs = Keyboard();

  Map<ControllerButton, void Function()> get _basicControllers => {
        ControllerButton.A_BUTTON: () =>
            keyboardControllerInputs.press(KeyboardKey.ENTER),
        ControllerButton.B_BUTTON: () =>
            keyboardControllerInputs.press(KeyboardKey.ESCAPE),
        ControllerButton.DPAD_UP: () =>
            keyboardControllerInputs.press(KeyboardKey.UP_ARROW),
        ControllerButton.DPAD_DOWN: () =>
            keyboardControllerInputs.press(KeyboardKey.DOWN_ARROW),
        ControllerButton.DPAD_LEFT: () =>
            keyboardControllerInputs.press(KeyboardKey.LEFT_ARROW),
        ControllerButton.DPAD_RIGHT: () =>
            keyboardControllerInputs.press(KeyboardKey.RIGHT_ARROW),
      };

  void init() {
    XInputManager.enableXInput();

    controller0 = Controller(index: 0);
    controller0.buttonsMapping = _basicControllers;

    controller0.lister();
  }

  void mapBasicControllers() {
    controller0.buttonsMapping?.addAll(_basicControllers);
  }
}
