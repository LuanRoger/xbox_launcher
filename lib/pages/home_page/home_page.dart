import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/game_model.dart';
import 'package:xbox_launcher/pages/configurations_page/configurations_page.dart';
import 'package:xbox_launcher/pages/models/xbox_page.dart';
import 'package:xbox_launcher/shared/widgets/clock_time.dart';
import 'package:xbox_launcher/shared/widgets/system_banner_button.dart';
import 'package:xbox_launcher/shared/widgets/xbox_user_info.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/game_button_tile.dart';
import 'package:xbox_launcher/shared/widgets/system_tile.dart';
class HomePage extends XboxPageStateless {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget virtualBuild(BuildContext context) {
    return Container(
      color: AppColors.DARK_BG,
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 0,
              child: Row(
                children: [
                  const Flexible(child: XboxUserInfo()),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(flex: 20, child: Icon(FluentIcons.mic_off)),
                        const Spacer(),
                        Flexible(flex: 0, child: ClockTimer()),
                      ],
                    ),
                  )
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
                    child: GameButtonTile(
                      GameModel(
                          "Hitman Tryology",
                          "https://www.xbox.com/pt-BR/play/launch/hitman-trilogy/9NN82NH949D5",
                          "https://maroonersrock.com/wp-content/uploads/2021/01/Hitman-3-Cover-Art.jpg"),
                      tileSize: TileSize.BIG,
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 0,
                    child: GameButtonTile(
                      GameModel(
                          "Forza Horizon 5",
                          "https://www.xbox.com/pt-BR/play/launch/forza-horizon-5-standard-edition/9NKX70BBCDRN",
                          "https://store-images.s-microsoft.com/image/apps.33953.13718773309227929.bebdcc0e-1ed5-4778-8732-f4ef65a2f445.9428b75f-2c08-4e70-9f95-281741b15341?w=1920&h=1080"),
                      tileSize: TileSize.MEDIUM,
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 30,
                    child: AppTile(
                      "Configurações",
                      icon: FluentIcons.settings,
                      tileSize: TileSize.MEDIUM,
                      onClick: (context) {
                        Navigator.push(
                            context,
                            FluentPageRoute(
                                builder: (context) => ConfigurationsPage()));
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
