import 'package:fluent_ui/fluent_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_scope.dart';
import 'package:xbox_launcher/shared/widgets/navigations/models/navigation_section_base.dart';
import 'package:xbox_launcher/shared/widgets/navigations/models/navigation_section_widget.dart';

abstract class NavigationSection extends HookConsumerWidget
    implements NavigationSectionBase, NavigationSectionWidget {
  @override
  final String sectionName;
  @override
  final ElementFocusScope? currentScope;

  const NavigationSection(this.sectionName, {Key? key, this.currentScope})
      : super(key: key);

  @override
  List<Widget> columnItems(BuildContext context, WidgetRef ref);
  @override
  List<Widget>? titleActions(BuildContext context, WidgetRef ref);

  Column _buildColumn(
      List<Widget> columnContent, List<Widget>? titleActionsList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
                style: AppTextStyle.MY_GAMES_SECTIONS_TILE,
              ),
              titleActionsList != null
                  ? Row(
                      children: titleActionsList,
                    )
                  : const SizedBox()
            ],
          ),
        ),
        ...columnContent,
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
        child: _buildColumn(
            columnItems(context, ref), titleActions(context, ref)));
  }
}
