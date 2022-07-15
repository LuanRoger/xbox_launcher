import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/models/mapping_definition.dart';
import 'package:xbox_launcher/providers/keyboard_action_provider.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page.dart';

abstract class XboxPageStateless extends StatelessWidget
    implements XboxPage, MappingDefinition {
  @override
  Map<ControllerKeyboardPair, void Function(BuildContext)>? pageKeysAction;

  XboxPageStateless({
    Key? key,
    this.pageKeysAction,
  }) : super(key: key);

  Widget virtualBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if (pageKeysAction != null) defineMapping(context);

    return CallbackShortcuts(
        bindings: Provider.of<KeyboardActionProvider>(context, listen: false)
            .keyboardBinding,
        child:
            Container(color: AppColors.DARK_BG, child: virtualBuild(context)));
  }
}
