import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/cover_generation_options.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/widget_gen.dart';

class TileCover extends StatelessWidget {
  Color? color;
  IconData? icon;
  Widget? customCover;
  ImageProvider? image;
  CoverGenerationOptions? generationOptions;

  TileCover(
      {Key? key,
      this.icon,
      this.color,
      this.customCover,
      this.image,
      this.generationOptions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
        builder: (_, value, __) => WidgetGen.generateTileCover(
            colorByGenerator: value.accentColor,
            color: color,
            icon: icon,
            customCover: customCover,
            image: image,
            generationOptions: generationOptions));
  }
}
