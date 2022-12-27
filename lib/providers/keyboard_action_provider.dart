import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/memento.dart';

class KeyboardActionProvider extends ChangeNotifier
    implements Memento<Map<ShortcutActivator, void Function()>> {
  @override
  List<Map<ShortcutActivator, void Function()>> mementoStack =
      List.empty(growable: true);
  Map<ShortcutActivator, void Function()> _keyboardBinding = {};

  Map<ShortcutActivator, void Function()> get keyboardBinding {
    return Map.from(_keyboardBinding);
  }

  void setKeyboardBinding(
      Map<ShortcutActivator, void Function()> keyboardBinding,
      {bool notifyChanges = true}) {
    _keyboardBinding = keyboardBinding;
    addToMementoStack();

    if (notifyChanges) notifyListeners();
  }

  void popLastBindig({bool notifyChanges = true}) {
    if (mementoStack.isEmpty) return;

    applyFromMementoStack();
    if (notifyChanges) notifyListeners();
  }

  @override
  void addToMementoStack() => mementoStack
      .add(Map<ShortcutActivator, void Function()>.from(_keyboardBinding));

  @override
  void applyFromMementoStack() {
    if (mementoStack.length == 1) {
      removeFromMementoStack();
      _keyboardBinding = {};
      return;
    }

    _keyboardBinding = mementoStack.removeLast();
  }

  @override
  Map<ShortcutActivator, void Function()> removeFromMementoStack() =>
      mementoStack.removeLast();
}
