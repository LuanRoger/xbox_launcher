import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/shared/widgets/buttons/icon_outlined_button.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_cover.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/cover_generation_options.dart';

class AppListItem extends StatelessWidget {
  AppModel appModel;
  void Function() onPressed;

  AppListItem(this.appModel, {Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconOutlinedButton(
      icon: TileCover.fromAppModel(appModel,
          generationOptions:
              CoverGenerationOptions(width: 50, height: 50, iconSize: 20)),
      text: appModel.name,
      onPressed: onPressed,
    );
  }
}
