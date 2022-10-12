import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/routes/app_routes.dart';
import 'package:xbox_launcher/shared/widgets/background.dart';
import 'package:xbox_launcher/shared/widgets/infos_provider/clock_time.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateless.dart';
import 'package:xbox_launcher/shared/widgets/placeholder_messages/wellcoming_message.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_banner_button.dart';
import 'package:xbox_launcher/shared/widgets/profile_avatar/profile_info.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_row.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/widget_gen.dart';

class HomePage extends XboxPageStateless {
  HomePage({Key? key}) : super(key: key);

  @override
  List<ShortcutOption>? defineMapping(BuildContext context) => null;

  @override
  Widget virtualBuild(BuildContext context) {
    return Stack(
      children: [
        const SizedBox(
            width: double.infinity,
            height: double.infinity,
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
                    const Flexible(child: ProfileInfo()),
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
                  child: Consumer<ProfileProvider>(
                    builder: (_, value, __) {
                      return value.lastApps.isEmpty
                          ? const WellcomingMessage()
                          : TileRow(
                              tiles: WidgetGen.generateByModel(
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
                        onClick: () => Navigator.pushNamed(
                            context, AppRoutes.myLibraryRoute),
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
