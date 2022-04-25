import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/game_model.dart';
import 'package:xbox_launcher/pages/configurations_page/configurations_page.dart';
import 'package:xbox_launcher/shared/widgets/system_banner_button.dart';
import 'package:xbox_launcher/shared/widgets/xbox_user_info.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/game_tile.dart';
import 'package:xbox_launcher/shared/widgets/system_tile.dart';

class BackNavigation extends Intent {}

class LoggingShortcutManager extends ShortcutManager {
  @override
  KeyEventResult handleKeypress(BuildContext context, RawKeyEvent event) {
    final KeyEventResult result = super.handleKeypress(context, event);
    if (result == KeyEventResult.handled) {
      print('Handled shortcut $event in $context');
    }
    return result;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.DARK_BG,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  XboxUserInfo(),
                  Text("00:00") //TODO: Create a clock
                ],
              ),
            ),
            const Spacer(),
            Flexible(
              flex: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 0,
                    child: GameTile(GameModel("Hitman Tryology",
                        "https://www.xbox.com/pt-BR/play/launch/hitman-trilogy/9NN82NH949D5",
                        imageUrl:
                            "https://maroonersrock.com/wp-content/uploads/2021/01/Hitman-3-Cover-Art.jpg")),
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 30,
                    child: SystemTile(
                      "Configurações",
                      FluentIcons.settings,
                      TileSize.MEDIUM,
                      onClick: (context) {
                        Navigator.push(
                            context,
                            FluentPageRoute(
                                builder: (context) =>
                                    const ConfigurationsPage()));
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Flexible(
              flex: 5,
              child: Row(
                children: [
                  Flexible(
                    child: SystemBannerButton(
                      "My games",
                      onClick: () {},
                      icon: FluentIcons.library,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
