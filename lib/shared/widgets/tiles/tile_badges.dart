import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xbox_launcher/models/app_badge_info.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/app_images.dart';

class TileBadges extends StatelessWidget {
  final double SVG_HEIGHT = 15.0;

  final AppBadgeInfo badgeInfo;

  const TileBadges(this.badgeInfo, {Key? key}) : super(key: key);

  List<Widget> _createRightBadges() {
    List<Widget> leftBadges = List.empty(growable: true);

    if (badgeInfo.controllerSupport) {
      leftBadges.add(Container(
        padding: const EdgeInsets.all(8.0),
        color: AppColors.ELEMENT_BG.withOpacity(0.5),
        child: SvgPicture.asset(
          AppImages.CONTROLLER_SUPPORT_BADGE,
          color: Colors.white,
          height: SVG_HEIGHT,
        ),
      ));
    }
    if (badgeInfo.touchSupport) {
      leftBadges.add(Container(
        padding: const EdgeInsets.all(8.0),
        color: AppColors.ELEMENT_BG.withOpacity(0.5),
        child: SvgPicture.asset(
          AppImages.TOUCH_SUPPORT,
          color: Colors.white,
          height: SVG_HEIGHT,
        ),
      ));
    }

    return leftBadges;
  }

  List<Widget> _createLeftBadge() {
    List<Widget> leftBadges = List.empty(growable: true);

    if (badgeInfo.isInGamePass) {
      leftBadges.add(SvgPicture.asset(
        AppImages.GAMEPASS_BADGE,
        color: Colors.white,
        allowDrawingOutsideViewBox: true,
        width: 100,
        height: SVG_HEIGHT,
      ));
    }

    return leftBadges;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _createLeftBadge(),
          ),
        ),
        Expanded(
          flex: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: _createRightBadges(),
          ),
        )
      ],
    );
  }
}
