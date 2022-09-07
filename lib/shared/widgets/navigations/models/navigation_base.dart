import 'package:fluent_ui/fluent_ui.dart';

abstract class NavigationBase {
  final int selectedTab;
  final List<NavigationPaneItem> paneItems;
  final List<Widget> bodyItems;

  NavigationBase(
      {this.selectedTab = 0, required this.paneItems, required this.bodyItems});
}
