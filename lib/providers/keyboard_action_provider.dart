import 'package:fluent_ui/fluent_ui.dart';

class KeyboardActionProvider {
  Map<ShortcutActivator, void Function()>? _defaultKeyboardBinding;
  Map<ShortcutActivator, void Function()> keyboardBinding = {};

  void setCurrentAsDefault() {
    _defaultKeyboardBinding =
        Map<ShortcutActivator, void Function()>.from(keyboardBinding);
  }

  void restoreDefault() {
    if (_defaultKeyboardBinding == null) return;

    keyboardBinding = _defaultKeyboardBinding!;
    _defaultKeyboardBinding = null;
  }
}
