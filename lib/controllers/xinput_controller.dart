import 'package:xinput_gamepad/xinput_gamepad.dart';

class XinputController {
  Controller controller = Controller(index: 0);

  void init() {
    XInputManager.enableXInput();
    controller.buttonsMapping = {
      ControllerButton.A_BUTTON: () => VirtualKeyboard.press(KeyboardKey.ENTER),
      //ControllerButton.B_BUTTON: () => VirtualKeyboard.press(KeyboardKey.E),
      ControllerButton.DPAD_UP: () =>
          VirtualKeyboard.press(KeyboardKey.UP_ARROW),
      ControllerButton.DPAD_DOWN: () =>
          VirtualKeyboard.press(KeyboardKey.DOWN_ARROW),
      ControllerButton.DPAD_LEFT: () =>
          VirtualKeyboard.press(KeyboardKey.LEFT_ARROW),
      ControllerButton.DPAD_RIGHT: () =>
          VirtualKeyboard.press(KeyboardKey.RIGHT_ARROW),
    };

    controller.lister();
  }
}
