import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/models/app_models/system_app_model.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/hooks/element_focus_node_hook.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_node.dart';
import 'package:xbox_launcher/shared/widgets/tiles/game_button_tile.dart';
import 'package:xbox_launcher/shared/widgets/tiles/models/tile_widget.dart';
import 'package:xbox_launcher/shared/widgets/tiles/system_app_tile.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/cover_generation_options.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';

class WidgetGen {
  static Widget generateTileCover(
      {required Color colorByGenerator,
      Color? color,
      ImageProvider? image,
      Widget? customCover,
      IconData? icon,
      CoverGenerationOptions? generationOptions}) {
    Widget _tileCover;
    Color accentColorTile = color ?? colorByGenerator;

    if (image != null) {
      _tileCover = Image(
        width: generationOptions?.width,
        height: generationOptions?.height,
        image: image,
        fit: BoxFit.cover,
      );
    } else if (customCover != null) {
      _tileCover = Container(
          width: generationOptions?.width,
          height: generationOptions?.height,
          alignment: Alignment.center,
          color: accentColorTile,
          child: customCover);
    } else if (icon != null) {
      _tileCover = Container(
        width: generationOptions?.width,
        height: generationOptions?.height,
        alignment: Alignment.center,
        color: accentColorTile,
        child: Icon(
          icon,
          color: Colors.white,
          size: generationOptions?.iconSize ?? 32,
        ),
      );
    } else {
      _tileCover = Container(
          width: generationOptions?.width,
          height: generationOptions?.height,
          color: accentColorTile);
    }

    return _tileCover;
  }
}
