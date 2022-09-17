import 'package:fluent_ui/fluent_ui.dart';

import 'controller_keyboard_pair.dart';

abstract class MappingDefinition {
  Map<ControllerKeyboardPair, void Function(BuildContext)>? defineMapping(
      BuildContext context);
}
