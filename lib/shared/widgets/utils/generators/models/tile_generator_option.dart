import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_scope.dart';

class TileGeneratorOption {
  List<TileSize> sizes;
  BuildContext context;
  ElementFocusScope? focusScope;

  TileGeneratorOption(this.sizes, {required this.context, this.focusScope});
}
