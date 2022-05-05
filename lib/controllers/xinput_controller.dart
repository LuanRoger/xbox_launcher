import 'package:xinput_gamepad/xinput_gamepad.dart';

class XInputController {
  late Controller _controller;

  void init() {
    XInputManager.enableXInput();

    _controller = Controller(index: 0);
    _controller.buttonsMapping = {
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
    _controller.lister();
  }
}
