import 'package:fluent_ui/fluent_ui.dart';

class NavigationItem extends PaneItem {
  NavigationItem(String title)
      : super(icon: const SizedBox(), title: Text(title));
}

class NavigationSeparatorItem extends PaneItemSeparator {}

class NavigationHeaderItem extends PaneItemHeader {
  NavigationHeaderItem(String header) : super(header: Text(header));
}
