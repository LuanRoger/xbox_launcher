import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_info.dart';

abstract class MappingDefinition {
  List<ShortcutInfo>? defineMapping(BuildContext context);
}
