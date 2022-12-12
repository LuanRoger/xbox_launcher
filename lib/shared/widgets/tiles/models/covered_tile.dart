import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_badge_info.dart';

abstract class CoveredTile {
  AppBadgeInfo? appBadgeInfo;
  IconData? icon;
  Widget? customCover;

  CoveredTile({this.appBadgeInfo, this.icon, this.customCover});
}