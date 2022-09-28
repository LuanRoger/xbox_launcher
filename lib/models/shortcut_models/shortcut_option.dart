import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';

class ShortcutOption {
  String description;
  ControllerKeyboardPair controllerKeyboardPair;
  void Function(BuildContext) action;
  bool show;
  MapEntry<ControllerKeyboardPair, void Function(BuildContext)>
      get rawShortcut => MapEntry(controllerKeyboardPair, action);

  ShortcutOption(this.description,
      {required this.controllerKeyboardPair,
      required this.action,
      this.show = true});
}
