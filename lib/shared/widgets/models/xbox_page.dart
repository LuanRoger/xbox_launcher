import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';

abstract class XboxPage {
  Map<ControllerKeyboardPair, void Function(BuildContext)> pageKeysAction;

  XboxPage(this.pageKeysAction);
}
