import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/keyboard_controller_action_manipulator.dart';
import 'package:xbox_launcher/models/mapping_definition.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/providers/keyboard_action_provider.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_builder.dart';
import 'package:xbox_launcher/shared/widgets/shortcuts/shortcuts_viewer.dart';

abstract class XboxPageStateful extends StatefulWidget {
  const XboxPageStateful({Key? key}) : super(key: key);
}

abstract class XboxPageState<T extends XboxPageStateful> extends State<T>
    implements MappingDefinition, XboxPageBuilder {
  ShortcutsViewer? shortcutsOverlay;

  Widget virtualBuild(BuildContext context);

  @override
  Widget genPageChild(BuildContext context) {
    if (shortcutsOverlay != null) {
      return Stack(children: [
        Container(color: AppColors.DARK_BG, child: virtualBuild(context)),
        shortcutsOverlay!
      ]);
    } else {
      return Container(color: AppColors.DARK_BG, child: virtualBuild(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ShortcutOption>? mapping = defineMapping(context);
    if (mapping != null) {
      KeyboardControllerActionManipulator.mapKeyboardControllerActions(
          context, Map.fromEntries(mapping.map((e) => e.rawShortcut)));
      shortcutsOverlay = ShortcutsViewer(mapping);
    }

    return CallbackShortcuts(
        bindings: Provider.of<KeyboardActionProvider>(context, listen: false)
            .keyboardBinding,
        child: genPageChild(context));
  }
}
