import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/apps_group.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/routes/app_routes.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu_base.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu_item.dart';
import 'package:xbox_launcher/shared/widgets/keyboard/keyboard_overlay.dart';

class ContextMenuGroup extends ContextMenuBase {
  @override
  late List<ContextMenuItem>? contextItems;
  final AppsGroup group;
  final TextEditingController renameController = TextEditingController();

  ContextMenuGroup(this.group) : super(group.groupName);

  @override
  Widget buildContextItemsList(BuildContext context) {
    contextItems = List.empty(growable: true);
    contextItems!.addAll([
      ContextMenuItem("Rename group", icon: FluentIcons.rename, onPressed: () {
        KeyboardOverlay(
          controller: renameController,
          onFinish: (cancel) {
            if (cancel) {
              Navigator.pop(context);
              return;
            }

            Provider.of<ProfileProvider>(context, listen: false)
                .renameGroup(group.id!, renameController.text);
            renameController.clear();
            Navigator.pop(context);
          },
        ).show(context);
      }),
      ContextMenuItem("Move group",
          icon: FluentIcons.group_object,
          onPressed: () => Navigator.pushReplacementNamed(
              context, AppRoutes.groupsReorderRoute)),
      ContextMenuItem("Remove group", icon: FluentIcons.remove_content,
          onPressed: () {
        Provider.of<ProfileProvider>(context, listen: false)
            .removeAppsGroup(group.id!);

        Navigator.pop(context);
      }),
    ]);

    return super.buildContextItemsList(context);
  }

  @override
  Widget dialogContentBuilder(BuildContext context) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
                child: Container(
              margin: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Text(
                title,
                style: AppTextStyle.CONTEXT_MENU_TITLE,
                overflow: TextOverflow.fade,
                maxLines: 1,
              ),
            )),
            const SizedBox(
              height: 10.0,
            ),
            buildContextItemsList(context)
          ]);
}
