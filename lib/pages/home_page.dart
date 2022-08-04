import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/controllers/keyboard_controller_action_manipulator.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/routes/app_routes.dart';
import 'package:xbox_launcher/shared/widgets/background.dart';
import 'package:xbox_launcher/shared/widgets/clock_time.dart';
import 'package:xbox_launcher/shared/widgets/models/xbox_page_stateless.dart';
import 'package:xbox_launcher/shared/widgets/placeholder_messages/wellcoming_message.dart';
import 'package:xbox_launcher/shared/widgets/buttons/system_banner_button.dart';
import 'package:xbox_launcher/shared/widgets/profile_avatar/profile_info.dart';
import 'package:xbox_launcher/shared/enums/tile_size.dart';
import 'package:xbox_launcher/shared/widgets/tiles/tile_row.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/models/tile_generator_option.dart';
import 'package:xbox_launcher/shared/widgets/utils/generators/widget_gen.dart';
import 'package:xbox_launcher/shared/widgets/xoverlay/xoverlay.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class HomePage extends XboxPageStateless {
  HomePage({Key? key})
      : super(key: key, pageKeysAction: {
          ControllerKeyboardPair(const SingleActivator(LogicalKeyboardKey.home),
              ControllerButton.START): (context) {
            XOverlay xOverlay = XOverlay();
            xOverlay.show(context);
          }
        });

  @override
  void defineMapping(BuildContext context) {
    KeyboardControllerActionManipulator.mapKeyboardControllerActions(
        context, pageKeysAction!);
  }

  @override
  Widget virtualBuild(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
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
                    Flexible(child: ProfileInfo()),
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
