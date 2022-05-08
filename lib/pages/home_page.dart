import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/game_model.dart';
import 'package:xbox_launcher/pages/configurations_page/configurations_page.dart';
import 'package:xbox_launcher/pages/models/xbox_page.dart';
import 'package:xbox_launcher/shared/widgets/background.dart';
import 'package:xbox_launcher/shared/widgets/clock_time.dart';
import 'package:xbox_launcher/shared/widgets/system_banner_button.dart';
import 'package:xbox_launcher/shared/widgets/xbox_user_info.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/game_button_tile.dart';
import 'package:xbox_launcher/shared/widgets/system_tile.dart';

class HomePage extends XboxPageStateless {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget virtualBuild(BuildContext context) {
    return Stack(
      children: [
        Container(height: double.infinity, width: double.infinity, child: const Background()),
        Padding(
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
                            "https://store-images.s-microsoft.com/image/apps.10042.14144194933273826.3ced5741-3e78-4437-9d89-92e9ac9b74fc.0f724e5e-5cff-424d-9920-a7b0de11eec6?w=300&h=300",
                            "https://store-images.s-microsoft.com/image/apps.8424.14144194933273826.3ced5741-3e78-4437-9d89-92e9ac9b74fc.731d758a-5b00-4082-887f-693b179a41b2?w=1920&h=1080"),
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
                            "https://store-images.s-microsoft.com/image/apps.18975.13718773309227929.bebdcc0e-1ed5-4778-8732-f4ef65a2f445.125d6b3b-492f-4e5f-8037-7ade230c8224?w=300&h=300",
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
                        onClick: (_) {
                          Navigator.push(
                              _,
                              FluentPageRoute(
                                  builder: (_) => ConfigurationsPage()));
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
      ],
    );
  }
}
