import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_images.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class ButtonsImageGen {
  static List<AssetImage> getButtonsImage(List<ControllerButton> buttons) {
    List<AssetImage> buttonsImage = List.empty(growable: true);

    for (var button in buttons) {
      switch (button) {
        case ControllerButton.START:
          buttonsImage.add(AppImages.START_BUTTON_IMAGE);
          break;
        case ControllerButton.BACK:
          buttonsImage.add(AppImages.BACK_BUTTON_IMAGE);
          break;
        case ControllerButton.A_BUTTON:
          buttonsImage.add(AppImages.A_BUTTON_IMAGE);
          break;
        case ControllerButton.B_BUTTON:
          buttonsImage.add(AppImages.B_BUTTON_IMAGE);
          break;
        case ControllerButton.X_BUTTON:
          buttonsImage.add(AppImages.X_BUTTON_IMAGE);
          break;
        case ControllerButton.Y_BUTTON:
          buttonsImage.add(AppImages.Y_BUTTON_IMAGE);
          break;
        default:
          break;
      }
    }
    return buttonsImage;
  }
}
