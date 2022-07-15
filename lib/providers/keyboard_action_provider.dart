import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/memento.dart';

class KeyboardActionProvider
    implements Memento<Map<ShortcutActivator, void Function()>> {
  @override
  List<Map<ShortcutActivator, void Function()>> mementoStack =
      List.empty(growable: true);
  Map<ShortcutActivator, void Function()> keyboardBinding = {};

  @override
  void addToMementoStack() => mementoStack
      .add(Map<ShortcutActivator, void Function()>.from(keyboardBinding));
  @override
  void applyFromMementoStack() => keyboardBinding = mementoStack.removeLast();
  @override
  Map<ShortcutActivator, void Function()> removeFromMementoStack() =>
      mementoStack.removeLast();
}