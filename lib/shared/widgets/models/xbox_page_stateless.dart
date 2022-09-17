import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/keyboard_controller_action_manipulator.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/models/mapping_definition.dart';
import 'package:xbox_launcher/providers/keyboard_action_provider.dart';
import 'package:xbox_launcher/shared/app_colors.dart';

abstract class XboxPageStateless extends StatelessWidget
    implements MappingDefinition {
  const XboxPageStateless({
    Key? key,
  }) : super(key: key);

  Widget virtualBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    Map<ControllerKeyboardPair, void Function(BuildContext)>? mapping =
        defineMapping(context);
    if (mapping != null) {
      KeyboardControllerActionManipulator.mapKeyboardControllerActions(
          context, mapping);
    }

    return CallbackShortcuts(
        bindings: Provider.of<KeyboardActionProvider>(context, listen: false)
            .keyboardBinding,
        child:
            Container(color: AppColors.DARK_BG, child: virtualBuild(context)));
  }
}
