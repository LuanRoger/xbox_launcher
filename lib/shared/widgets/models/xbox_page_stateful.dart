import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/keyboard_controller_action_manipulator.dart';
import 'package:xbox_launcher/models/mapping_definition.dart';
import 'package:xbox_launcher/models/shortcut_activator.dart';
import 'package:xbox_launcher/providers/keyboard_action_provider.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/widgets/shortcuts/shortcuts_overlay.dart';

abstract class XboxPageStateful extends StatefulWidget {
  const XboxPageStateful({Key? key}) : super(key: key);
}

abstract class XboxPageState<T extends XboxPageStateful> extends State<T>
    implements MappingDefinition {
  ShortcutsOverlay? shortcutsOverlay;

  Widget virtualBuild(BuildContext context);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => shortcutsOverlay?.show(context));
  }

  @override
  Widget build(BuildContext context) {
    List<ShortcutOption>? mapping = defineMapping(context);
    if (mapping != null) {
      KeyboardControllerActionManipulator.mapKeyboardControllerActions(
          context, Map.fromEntries(mapping.map((e) => e.rawShortcut)));
      shortcutsOverlay = ShortcutsOverlay({
        for (var element in mapping)
          element.controllerKeyboardPair.controllerButton: element.description
      });
    }

    return CallbackShortcuts(
        bindings: Provider.of<KeyboardActionProvider>(context, listen: false)
            .keyboardBinding,
        child:
            Container(color: AppColors.DARK_BG, child: virtualBuild(context)));
  }
}
