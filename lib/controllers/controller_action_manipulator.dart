import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/providers/controller_action_provider.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class ControllerActionManipulator {
  static void mapControllerActions(BuildContext context,
      List<ShortcutOption> shortcutsOptions, bool putIntoMemento) {
    if (shortcutsOptions.isEmpty) return;

    var controllerProvider =
        Provider.of<ControllerActionProvider>(context, listen: false);

    Map<ControllerButton, void Function()> controllerMapping = {};
    for (var action in shortcutsOptions
        .map((shortcutOption) => shortcutOption.rawShortcut)) {
      controllerMapping[action.key.controllerButton] = () => action.value();
    }

    controllerProvider.setControllerMapping(controllerMapping, putIntoMemento: putIntoMemento);
  }

  static void applyMementoInAll(BuildContext context) {
    Provider.of<ControllerActionProvider>(context, listen: false)
        .popLastKeyboardBindig();
  }
}
