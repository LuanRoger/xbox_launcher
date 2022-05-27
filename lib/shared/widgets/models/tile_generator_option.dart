import 'package:flutter/cupertino.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';

class TileGeneratorOption {
  List<TileSize> sizes;
  BuildContext context;

  TileGeneratorOption(this.sizes, {required this.context});
}
