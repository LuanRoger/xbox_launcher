import 'package:fluent_ui/fluent_ui.dart' hide Overlay;
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/profile_model.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/widgets/models/overlay.dart';
import 'package:xbox_launcher/shared/widgets/navigations/navigation_top.dart';
import 'package:xbox_launcher/shared/widgets/profile_avatar/profile_avatar.dart';
import 'package:xbox_launcher/shared/widgets/profile_avatar/profile_image_avatar.dart';
import 'package:xbox_launcher/shared/widgets/xoverlay/sections/xoverlay_home_section.dart';
import 'package:xbox_launcher/shared/widgets/xoverlay/sections/xoverlay_profile_section.dart';

class XOverlay extends Overlay {
  Type? callContext;
  int _currentPane = 0;

  void Function(void Function())? _updateNavPane;

  XOverlay({this.callContext});

  void _goToPane(int paneIndex) {
    _updateNavPane?.call(() => _currentPane = paneIndex);
  }

  @override
  void show(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Align(
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
        );
      },
    );
  }
}
