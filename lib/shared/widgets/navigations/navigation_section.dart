import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

abstract class NavigationSection extends StatelessWidget {
  String sectionName;

  NavigationSection(this.sectionName, {Key? key}) : super(key: key);

  List<Widget> buildColumnItems(BuildContext context);
  List<Widget>? buildActions(BuildContext context);

  List<Widget> _buildColumnItems(
      List<Widget> columnContent, List<Widget>? actions) {
    List<Widget> columnItems = List<Widget>.empty(growable: true);

    columnItems.addAll([
      Flexible(
          flex: 0,
          child: Text(
            sectionName,
            style: AppTextStyle.MY_GAMES_SECTIONS_TILE,
          )),
      const Spacer(),
    ]);

    if (actions != null) {
      columnItems.addAll([
        Flexible(
          flex: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: actions,
          ),
        ),
        const Spacer(),
      ]);
    }

    columnItems.addAll(columnContent);

    return columnItems;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            _buildColumnItems(buildColumnItems(context), buildActions(context)),
      ),
    );
  }
}
