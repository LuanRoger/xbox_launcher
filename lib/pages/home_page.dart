import 'package:fluent_ui/fluent_ui.dart' hide FluentIcons;
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/routes/app_routes.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/app_consts.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/background.dart';
import 'package:xbox_launcher/shared/widgets/buttons/icon_text_gradient_button.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/external_site_dialog.dart';
import 'package:xbox_launcher/shared/widgets/infos_provider/clock_time.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page.dart';
import 'package:xbox_launcher/shared/widgets/placeholder_messages/wellcoming_message.dart';
import 'package:xbox_launcher/shared/widgets/profile_avatar/profile_info.dart';
import 'package:xbox_launcher/shared/widgets/tiles/app_tiles_row.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';

class HomePage extends XboxPage {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends XboxPageState<HomePage> {
  @override
  List<ShortcutOption>? defineMapping(BuildContext context) => null;

  @override
  Widget virtualBuild(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Background()),
        Padding(
          padding: const EdgeInsets.only(left: 80, top: 50, right: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
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
              Expanded(
                flex: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<ProfileProvider>(
                      builder: (_, value, __) {
                        return value.lastApps.isEmpty
                            ? const WellcomingMessage()
                            : AppsTileRow(
                                tiles: value.lastApps,
                                customGenerateOption: TileGeneratorOption(
                                    tilesSize: TileSize.MEDIUM,
                                    context: context,
                                    focusScope: elementFocusScope),
                              );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 50,
                          child: IconTextGradientButton(
                            title: "My games & apps",
                            onPressed: () => Navigator.pushNamed(
                                context, AppRoutes.myLibraryRoute),
                            icon: FluentIcons.library_28_regular,
                            width: 120,
                            height: 130,
                            gradientColors: const [
                              AppColors.DARK_GREEN,
                              AppColors.GREEN
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                        ),
                        const Spacer(),
                        Flexible(
                          flex: 50,
                          child: IconTextGradientButton(
                            title: "Xbox Cloud Gamming",
                            onPressed: () async => ExternalSiteDialog(
                                    Uri.parse(AppConsts.XCLOUD_PLAIN_URL))
                                .show(context),
                            icon: FluentIcons.xbox_controller_24_regular,
                            width: 120,
                            height: 130,
                            gradientColors: const [
                              AppColors.DARK_BLUE,
                              AppColors.LIGHT_BLUE
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                        ),
                      ],
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
