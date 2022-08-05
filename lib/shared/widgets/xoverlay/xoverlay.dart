import 'package:fluent_ui/fluent_ui.dart' hide Overlay;
import 'package:flutter/services.dart';
import 'package:xbox_launcher/controllers/keyboard_controller_action_manipulator.dart';
import 'package:xbox_launcher/models/controller_keyboard_pair.dart';
import 'package:xbox_launcher/models/mapping_definition.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/clock_time.dart';
import 'package:xbox_launcher/shared/widgets/models/overlay.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_top.dart';
import 'package:xbox_launcher/shared/widgets/profile_avatar/profile_image_avatar.dart';
import 'package:xbox_launcher/shared/widgets/xoverlay/sections/xoverlay_home_section.dart';
import 'package:xbox_launcher/shared/widgets/xoverlay/sections/xoverlay_profile_section.dart';
import 'package:xinput_gamepad/xinput_gamepad.dart';

class XOverlay extends Overlay implements MappingDefinition {
  Type? callContext;
  int _currentPane = 0;

  void Function(void Function())? _updateNavPane;

  XOverlay({this.callContext});

  void _goToPane(int paneIndex) {
    _updateNavPane?.call(() => _currentPane = paneIndex);
  }

  @override
  void defineMapping(BuildContext context) {
    KeyboardControllerActionManipulator.saveAllCurrentAtMemento(context);

    KeyboardControllerActionManipulator.mapKeyboardControllerActions(context, {
      ControllerKeyboardPair(const SingleActivator(LogicalKeyboardKey.escape),
          ControllerButton.B_BUTTON): (context) => Navigator.pop(context)
    });
  }

  @override
  void show(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                    width: width * 0.3,
                    height: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: StatefulBuilder(builder: (context, setState) {
                        _updateNavPane = setState;

                        return NavigationTop(paneItems: [
                          PaneItem(icon: ProfileImageAvatar()),
                          PaneItem(
                              icon: const Icon(
                            FluentIcons.home,
                            size: 25,
                          )),
                          PaneItem(
                              icon: const Icon(
                            FluentIcons.game,
                            size: 25,
                          ))
                        ], bodyItems: [
                          XOverlayProfileSection(),
                          XOverlayHomeSection()
                        ]);
                      }),
                    )),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: ClockTimer(
                    textStyle: AppTextStyle.CLOCK_TEXT_BIG,
                  ))
            ],
          ),
        );
      },
    );
  }
}
