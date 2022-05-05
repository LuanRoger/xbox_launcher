// ignore_for_file: no_logic_in_create_state

import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';

abstract class XboxPageStateful extends StatefulWidget {
  late Map<ShortcutActivator, void Function()> _keyboardBinding;
  Map<ControllerKeyboardPair, void Function(BuildContext context)>? keyAction;

  XboxPageStateful({Key? key, this.keyAction}) : super(key: key);

  void _mapKeyboardShortcuts(BuildContext context) {
    if (keyAction == null) return;

    Map<ShortcutActivator, void Function()> binding =
        <ShortcutActivator, void Function()>{};

    keyAction!.forEach((key, value) {
      binding[SingleActivator(key.keyboardkey)] = () => value(context);
    });

    _keyboardBinding = binding;
  }

  State<StatefulWidget> vitualCreateState();

  @override
  State<StatefulWidget> createState() => vitualCreateState();
}

abstract class XboxPageState<T extends XboxPageStateful> extends State<T> {
  Widget virtualBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    widget._mapKeyboardShortcuts(context);

    return widget.keyAction != null
        ? CallbackShortcuts(
            bindings: widget._keyboardBinding, child: virtualBuild(context))
        : virtualBuild(context);
  }
}
