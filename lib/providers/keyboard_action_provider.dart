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

  set keyboardBinding(Map<ShortcutActivator, void Function()> keyboardBinding) {
    _keyboardBinding = keyboardBinding;

    notifyListeners();
  }

  @override
  void addToMementoStack() => mementoStack
      .add(Map<ShortcutActivator, void Function()>.from(_keyboardBinding));
  @override
  void applyFromMementoStack() => _keyboardBinding = mementoStack.removeLast();
  @override
  Map<ShortcutActivator, void Function()> removeFromMementoStack() =>
      mementoStack.removeLast();
}
