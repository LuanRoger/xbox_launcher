import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/models/app_models/external_game_model.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/models/app_models/system_app_model.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';
import 'package:xbox_launcher/shared/widgets/external_game_icon.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/cover_generation_options.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/widget_gen.dart';

class TileCover extends StatelessWidget {
  final AppModel? appModel;
  final Color? color;
  final CoverGenerationOptions? generationOptions;
  final IconData? icon;
  final Widget? customCover;
  final ImageProvider? image;

  const TileCover(
      {Key? key,
      this.appModel,
      this.color,
      this.icon,
      this.customCover,
      this.image,
      this.generationOptions})
      : super(key: key);

  factory TileCover.fromAppModel(AppModel appModel,
      {Color? color, CoverGenerationOptions? generationOptions}) {
    IconData? iconAppModel;
    Widget? customCoverAppModel;
    ImageProvider? imageAppModel;

    switch (appModel.appType) {
      case AppType.GAME:
        GameModel appGameModel = appModel as GameModel;
        imageAppModel = NetworkImage(appGameModel.tileGameImageUrl);
        break;
      case AppType.SYSTEM_APP:
        SystemAppModel systemAppModel = appModel as SystemAppModel;
        iconAppModel = systemAppModel.icon;
        break;
      case AppType.EXTERNAL_APP:
        ExternalGameModel externalGameModel = appModel as ExternalGameModel;
        imageAppModel = externalGameModel.imagePath != null
            ? FileImage(File(externalGameModel.imagePath!))
            : null;
        customCoverAppModel = externalGameModel.iconUrl != null
            ? ExternalGameIcon(iconUrl: externalGameModel.iconUrl)
            : null;
        break;
    }

    return TileCover(
      color: color,
      icon: iconAppModel,
      customCover: customCoverAppModel,
      image: imageAppModel,
      generationOptions: generationOptions,
    );
  }

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
