import 'package:fluent_ui/fluent_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class NavigationSectionWidget {
  List<Widget> columnItems(BuildContext context, WidgetRef ref);
  List<Widget>? titleActions(BuildContext context, WidgetRef ref);
}
