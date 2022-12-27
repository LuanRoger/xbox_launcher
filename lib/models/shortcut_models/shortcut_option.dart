import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_info.dart';

class ShortcutOption extends ShortcutInfo {
  void Function() action;
  MapEntry<ControllerKeyboardPair, void Function()> get rawShortcut =>
      MapEntry(controllerKeyboardPair, action);

  ShortcutOption(super.description,
      {required super.controllerKeyboardPair,
      required this.action,
      super.show});
}
