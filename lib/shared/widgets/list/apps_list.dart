import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/list/app_list_item.dart';

class AppsList extends StatelessWidget {
  final int itemCount;
  final bool shrinkWrap;
  final ScrollPhysics? scrollPhysics;
  final AppListItem Function(BuildContext, int) itemBuilder;

  const AppsList(
      {Key? key,
      required this.itemBuilder,
      required this.itemCount,
      this.shrinkWrap = false,
      this.scrollPhysics})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: scrollPhysics,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
    );
  }
}
