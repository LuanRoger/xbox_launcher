import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/apps_history.dart';
import 'package:xbox_launcher/pages/my_library_page/my_library_page.dart';
import 'package:xbox_launcher/shared/widgets/models/tile_generator_option.dart';
import 'package:xbox_launcher/shared/widgets/models/tile_type_generate.dart';
import 'package:xbox_launcher/shared/widgets/background.dart';
import 'package:xbox_launcher/shared/widgets/clock_time.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateless.dart';
import 'package:xbox_launcher/shared/widgets/system_banner_button.dart';
import 'package:xbox_launcher/shared/widgets/tile_row.dart';
import 'package:xbox_launcher/shared/widgets/xbox_user_info.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';

class HomePage extends XboxPageStateless {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget virtualBuild(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Background()),
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
                        children: const [
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
                  child: Consumer<AppsHistory>(
                    builder: (_, value, __) {
                      return TileRow(
                          tiles: TileTypeGenerate.generateByModel(
                              value.lastApps,
                              TileGeneratorOption(
                                  [TileSize.BIG, TileSize.MEDIUM],
                                  context: context)));
                    },
                  )),
              const Spacer(),
              Flexible(
                flex: 5,
                child: Row(
                  children: [
                    Flexible(
                      child: SystemBannerButton(
                        "My games",
                        onClick: () => Navigator.push(context,
                            FluentPageRoute(builder: (_) => MyLibraryPage())),
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
