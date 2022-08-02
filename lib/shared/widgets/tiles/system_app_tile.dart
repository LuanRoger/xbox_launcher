import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/app_models/system_app_model.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/routes/app_routes.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/tiles/button_tile.dart';

class SystemAppButtonTile extends ButtonTile {
  SystemAppModel appModel;

  SystemAppButtonTile(this.appModel,
      {Key? key,
      required BuildContext context, //Context to navigate
      required TileSize tileSize})
      : super(appModel.name, true,
            key: key, tileSize: tileSize, icon: appModel.icon, onPressed: (_) {
          Navigator.pushNamed(context, AppRoutes.systemAppRoute, arguments: [appModel.appHome!]);
          Provider.of<ProfileProvider>(context, listen: false)
              .addAppToHistory(appModel);
        });
}
