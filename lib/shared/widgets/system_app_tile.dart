import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/apps_history.dart';
import 'package:xbox_launcher/models/system_app_model.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/button_tile.dart';

class SystemAppButtonTile extends ButtonTile {
  SystemAppModel appModel;

  SystemAppButtonTile(this.appModel,
      {Key? key, required TileSize tileSize, bool track = false})
      : super(appModel.name, true,
            key: key,
            tileSize: tileSize,
            icon: appModel.icon, onPressed: (BuildContext context) {
          appModel.onClick?.call(context);
          Provider.of<AppsHistory>(context, listen: false).addApp(appModel);
        });
}
