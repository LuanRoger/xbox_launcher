import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/list/app_list_item.dart';

class AppsList extends StatelessWidget {
  int itemCount;
  bool shrinkWrap;
  ScrollPhysics? scrollPhysics;
  AppListItem Function(BuildContext, int) itemBuilder;

  AppsList(
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
