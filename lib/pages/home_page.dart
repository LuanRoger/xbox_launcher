import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart' hide FluentIcons;
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/system_app_controller.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/models/shortcut_models/shortcut_option.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/routes/app_routes.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/app_consts.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/background.dart';
import 'package:xbox_launcher/shared/widgets/buttons/icon_text_gradient_button.dart';
import 'package:xbox_launcher/shared/widgets/buttons/models/system_icon_button.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu_item.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/external_site_dialog.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/menu_dialog_overlay.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/system_dialog.dart';
import 'package:xbox_launcher/shared/widgets/infos_provider/clock_time.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page.dart';
import 'package:xbox_launcher/shared/widgets/placeholder_messages/wellcoming_message.dart';
import 'package:xbox_launcher/shared/widgets/profile_avatar/profile_info.dart';
import 'package:xbox_launcher/shared/widgets/tiles/app_tiles_row.dart';
import 'package:xbox_launcher/shared/widgets/utils/commands/models/command_invoker.dart';
import 'package:xbox_launcher/shared/widgets/utils/commands/open_app_command.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class HomePage extends XboxPage {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends XboxPageState<HomePage> {
  Future _showMenu(BuildContext context) async {
    await ContextMenu("System", contextItems: [
      ContextMenuItem("Exit",
          icon: FluentIcons.sign_out_24_regular, onPressed: () => exit(0))
    ]).show(context);
  }

  @override
  List<ShortcutOption>? defineMapping(BuildContext context) => [
        ShortcutOption("Options",
            controllerKeyboardPair: ControllerKeyboardPair(
                const SingleActivator(LogicalKeyboardKey.f1),
                ControllerButton.BACK),
            action: () async => await _showMenu(context),
            show: false)
      ];

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
          padding: const EdgeInsets.only(left: 70, top: 50, right: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 0,
                child: Row(
                  children: [
                    const Expanded(child: ProfileInfo()),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            flex: 10,
                            child: SystemIconButton(
                              icon: const Icon(
                                FluentIcons.settings_28_regular,
                                size: 20,
                              ),
                              onPressed: () {
                                CommandInvoker command = CommandInvoker(
                                    OpenAppCommand(
                                        SystemAppController.getByName(
                                            "Configurations"),
                                        context: context));
                                command.execute();
                              },
                            ),
                          ),
                          const Spacer(),
                          const Flexible(flex: 10, child: ClockTimer()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<ProfileProvider>(
                      builder: (_, value, __) {
                        return value.lastApps.isEmpty
                            ? const WellcomingMessage()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Jump back in",
                                    style: AppTextStyle.APPS_GAMES_ROW_TITLE,
                                  ),
                                  AppsTileRow(
                                    tiles: value.lastApps,
                                    customGenerateOption: TileGeneratorOption(
                                        tilesSize: TileSize.MEDIUM,
                                        context: context,
                                        focusScope: elementFocusScope),
                                  ),
                                ],
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
