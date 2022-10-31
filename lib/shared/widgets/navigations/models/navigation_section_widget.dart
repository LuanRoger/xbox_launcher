import 'package:fluent_ui/fluent_ui.dart';

abstract class NavigationSectionWidget {
  List<Widget> columnItems(BuildContext context);
  List<Widget>? titleActions(BuildContext context);
}
