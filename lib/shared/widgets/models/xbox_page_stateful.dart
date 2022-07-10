// ignore_for_file: no_logic_in_create_state

import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/shared/app_colors.dart';

abstract class XboxPageStateful extends StatefulWidget {
  Map<ControllerKeyboardPair, void Function(BuildContext context)>? keyAction;

  XboxPageStateful({Key? key, this.keyAction}) : super(key: key);

  State<StatefulWidget> vitualCreateState();

  @override
  State<StatefulWidget> createState() => vitualCreateState();
}

abstract class XboxPageState<T extends XboxPageStateful> extends State<T> {
  late Map<ShortcutActivator, void Function()> _keyboardBinding;
  Widget virtualBuild(BuildContext context);

  @override
  void initState() {
    super.initState();
    _mapKeyboardShortcuts(context);
  }

  void _mapKeyboardShortcuts(BuildContext context) {
    if (widget.keyAction == null) return;

    Map<ShortcutActivator, void Function()> binding = {};

    widget.keyAction!.forEach((key, value) {
      binding[SingleActivator(key.keyboardkey)] = () => value(context);
    });

    _keyboardBinding = binding;
  }

  @override
  Widget build(BuildContext context) {
    return widget.keyAction != null
        ? CallbackShortcuts(
            bindings: _keyboardBinding,
            child: Container(
                color: AppColors.DARK_BG, child: virtualBuild(context)))
        : Container(color: AppColors.DARK_BG, child: virtualBuild(context));
  }
}
