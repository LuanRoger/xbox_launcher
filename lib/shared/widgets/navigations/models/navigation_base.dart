import 'package:fluent_ui/fluent_ui.dart';

abstract class NavigationBase {
  final int selectedTab;
  final List<PaneItem> paneItems;

  NavigationBase({this.selectedTab = 0, required this.paneItems});
}
