import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/memento.dart';

class KeyboardActionProvider extends ChangeNotifier
    implements Memento<Map<ShortcutActivator, void Function()>> {
  Map<ShortcutActivator, void Function()> _keyboardBindings = {};
  Map<ShortcutActivator, void Function()> get keyboardBindings =>
      Map.from(_keyboardBindings);

  @override
  List<Map<ShortcutActivator, void Function()>> mementoStack =
      List.empty(growable: true);

  void setKeyboardBinding(
      Map<ShortcutActivator, void Function()> keyboardBinding,
      {bool notify = true}) {
    addToMementoStack();
    _keyboardBindings = keyboardBinding;

    if (notify) notifyListeners();
  }

  void updateKeyboardBinding(
      Map<ShortcutActivator, void Function()> keyboardBinding,
      {bool notify = true}) {
    _keyboardBindings = keyboardBinding;

    if (notify) notifyListeners();
  }

  @override
  void addToMementoStack() => mementoStack
      .add(Map<ShortcutActivator, void Function()>.from(_keyboardBindings));
  @override
  void applyFromMementoStack() {
    _keyboardBindings = mementoStack.removeLast();
    notifyListeners();
  }

  @override
  Map<ShortcutActivator, void Function()> removeFromMementoStack() =>
      mementoStack.removeLast();
}
