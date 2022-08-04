import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/models/app_models/external_game_model.dart';
import 'package:xbox_launcher/models/app_models/game_model.dart';
import 'package:xbox_launcher/models/app_models/system_app_model.dart';
import 'package:xbox_launcher/shared/enums/app_type.dart';
import 'package:xbox_launcher/shared/widgets/buttons/icon_outlined_button.dart';
import 'package:xbox_launcher/shared/widgets/external_game_icon.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_cover.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/cover_generation_options.dart';

class AppListItem extends StatelessWidget {
  AppModel appModel;
  IconData? icon;
  ImageProvider? image;
  Widget? customCover;

  AppListItem(this.appModel, {Key? key}) : super(key: key) {
    //TODO: Move to TileCover
    switch (appModel.appType) {
      case AppType.GAME:
        GameModel appGameModel = appModel as GameModel;
        image = NetworkImage(appGameModel.tileGameImageUrl);
        break;
      case AppType.SYSTEM_APP:
        SystemAppModel systemAppModel = appModel as SystemAppModel;
        icon = systemAppModel.icon;
        break;
      case AppType.EXTERNAL_APP:
        ExternalGameModel externalGameModel = appModel as ExternalGameModel;
        image = externalGameModel.imagePath != null
            ? FileImage(File(externalGameModel.imagePath!))
            : null;
        customCover = externalGameModel.iconUrl != null
            ? ExternalGameIcon(iconUrl: externalGameModel.iconUrl)
            : null;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconOutlinedButton(
      icon: TileCover(
          image: image,
          icon: icon,
          customCover: customCover,
          generationOptions:
              CoverGenerationOptions(width: 50, height: 50, iconSize: 20)),
      text: appModel.name,
      onPressed: () {},
    );
  }
}
