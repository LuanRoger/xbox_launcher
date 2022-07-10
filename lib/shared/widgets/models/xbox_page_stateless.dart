import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/shared/app_colors.dart';

abstract class XboxPageStateless extends StatelessWidget {
  late Map<ShortcutActivator, void Function()> _keyboardBinding;
  Map<ControllerKeyboardPair, void Function(BuildContext context)>? keyAction;

  XboxPageStateless({Key? key, this.keyAction}) : super(key: key);

  void mapKeyboardShortcuts(BuildContext context) {
    if (keyAction == null) return;

    Map<ShortcutActivator, void Function()> binding = {};

    keyAction!.forEach((key, value) {
      binding[SingleActivator(key.keyboardkey)] = () => value(context);
    });

    _keyboardBinding = binding;
  }

  Widget virtualBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    mapKeyboardShortcuts(context);

    return keyAction != null
        ? CallbackShortcuts(
            bindings: _keyboardBinding,
            child: Container(
                color: AppColors.DARK_BG, child: virtualBuild(context)))
        : Container(color: AppColors.DARK_BG, child: virtualBuild(context));
  }
}
