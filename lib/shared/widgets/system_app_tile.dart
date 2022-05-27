import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/apps_history.dart';
import 'package:xbox_launcher/models/system_app_model.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/button_tile.dart';

class SystemAppButtonTile extends ButtonTile {
  SystemAppModel appModel;

  SystemAppButtonTile(this.appModel,
      {Key? key,
      required BuildContext context, //Context to navigate
      required TileSize tileSize})
      : super(appModel.name!, true,
            key: key, tileSize: tileSize, icon: appModel.icon, onPressed: (_) {
          Navigator.push(
              context, FluentPageRoute(builder: (_) => appModel.appHome!));
          Provider.of<AppsHistory>(context, listen: false).addApp(appModel);
        });
}
