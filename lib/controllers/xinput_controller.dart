import 'package:xinput_gamepad/xinput_gamepad.dart';

class XInputController {
  late Controller controller0;
  //Not supported yet
  late Controller controller1;
  late Controller controller2;
  late Controller controller3;
  late Controller controller4;

  void init() {
    XInputManager.enableXInput();

    controller0 = Controller(index: 0);
    controller0.buttonsMapping = {
      ControllerButton.A_BUTTON: () => VirtualKeyboard.press(KeyboardKey.ENTER),
      ControllerButton.B_BUTTON: () =>
          VirtualKeyboard.press(KeyboardKey.ESCAPE),
      ControllerButton.DPAD_UP: () =>
          VirtualKeyboard.press(KeyboardKey.UP_ARROW),
      ControllerButton.DPAD_DOWN: () =>
          VirtualKeyboard.press(KeyboardKey.DOWN_ARROW),
      ControllerButton.DPAD_LEFT: () =>
          VirtualKeyboard.press(KeyboardKey.LEFT_ARROW),
      ControllerButton.DPAD_RIGHT: () =>
          VirtualKeyboard.press(KeyboardKey.RIGHT_ARROW),
    };
    controller0.lister();
  }
}
