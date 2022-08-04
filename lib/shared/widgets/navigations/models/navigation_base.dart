import 'package:fluent_ui/fluent_ui.dart';

abstract class NavigationBase {
  int selectedTab;
  List<NavigationPaneItem> paneItems;
  List<Widget> bodyItems;

  NavigationBase(
      {this.selectedTab = 0, required this.paneItems, required this.bodyItems});
}
