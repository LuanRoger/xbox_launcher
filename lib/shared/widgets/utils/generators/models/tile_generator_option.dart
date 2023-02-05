import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_scope.dart';

class TileGeneratorOption {
  BuildContext context;
  ElementFocusScope? focusScope;
  TileSize tilesSize;

  TileGeneratorOption(
      {this.focusScope,
      this.tilesSize = TileSize.MEDIUM,
      required this.context});
}
