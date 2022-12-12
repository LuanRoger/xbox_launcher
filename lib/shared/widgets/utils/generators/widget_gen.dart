import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/cover_generation_options.dart';

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
