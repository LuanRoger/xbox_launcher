import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/shared/widgets/list/app_list_item.dart';

class AppsList extends StatelessWidget {
  List<AppModel> appItems;
  int? limit;

  AppsList(this.appItems, {Key? key, this.limit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (_, index) => AppListItem(appItems[index]),
      itemCount:
          limit != null && limit! < appItems.length ? limit : appItems.length,
    );
  }
}
