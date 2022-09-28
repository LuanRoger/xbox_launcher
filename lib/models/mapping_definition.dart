import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/shortcut_activator.dart';

abstract class MappingDefinition {
  List<ShortcutOption>? defineMapping(BuildContext context);
}
