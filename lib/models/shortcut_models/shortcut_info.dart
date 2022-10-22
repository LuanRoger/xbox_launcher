import 'package:xbox_launcher/models/controller_keyboard_pair.dart';

class ShortcutInfo {
  String description;
  ControllerKeyboardPair controllerKeyboardPair;
  bool show;

  ShortcutInfo(this.description,
      {required this.controllerKeyboardPair, this.show = true});
}
