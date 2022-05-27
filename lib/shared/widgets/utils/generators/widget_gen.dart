import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/system_app_model.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/models/navigation_item.dart';
import 'package:xbox_launcher/shared/widgets/system_app_tile.dart';

class WidgetGen {
  static List<NavigationPaneItem> generatePaneItems(
      List<NavigationItem> paneItems) {
    List<NavigationPaneItem> barItems = List.empty(growable: true);
    for (NavigationItem item in paneItems) {
      barItems.add(PaneItem(icon: const SizedBox(), title: Text(item.text)));
    }

    return barItems;
  }

  static Widget generateTileCover(
      {required Color colorByGenerator,
      Color? color,
      ImageProvider? image,
      IconData? icon}) {
    Widget _tileCover;
    if (image != null) {
      _tileCover = Image(
        image: image,
        fit: BoxFit.cover,
      );
    } else if (icon != null) {
      _tileCover = Container(
        color: color ?? colorByGenerator,
        child: Align(
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: Colors.white,
            size: 35,
          ),
        ),
      );
    } else {
      _tileCover = Container(color: color ?? colorByGenerator);
    }

    return _tileCover;
  }

  static List<SystemAppButtonTile> generateSystemAppsTiles(
      List<SystemAppModel> apps, BuildContext context) {
    List<SystemAppButtonTile> appsTile = List.empty(growable: true);

    for (SystemAppModel app in apps) {
      appsTile.add(SystemAppButtonTile(
        app,
        tileSize: TileSize.MEDIUM,
        context: context,
      ));
    }

    return appsTile;
  }
}
