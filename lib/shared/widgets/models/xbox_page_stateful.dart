import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/models/mapping_definition.dart';
import 'package:xbox_launcher/providers/keyboard_action_provider.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page.dart';

abstract class XboxPageStateful extends StatefulWidget implements XboxPage {
  @override
  Map<ControllerKeyboardPair, void Function(BuildContext)>? pageKeysAction;

  XboxPageStateful({Key? key, this.pageKeysAction}) : super(key: key);
}

abstract class XboxPageState<T extends XboxPageStateful> extends State<T>
    implements MappingDefinition {
  bool _hasBeenMappign = false;

  Widget virtualBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if (!_hasBeenMappign && widget.pageKeysAction != null) {
      defineMapping(context);
      _hasBeenMappign = true;
    }

    return CallbackShortcuts(
        bindings: Provider.of<KeyboardActionProvider>(context, listen: false)
            .keyboardBinding,
        child:
            Container(color: AppColors.DARK_BG, child: virtualBuild(context)));
  }
}
