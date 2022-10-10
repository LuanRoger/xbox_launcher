import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/models/apps_group.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu_base.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu_item.dart';
import 'package:xbox_launcher/shared/widgets/keyboard/keyboard_overlay.dart';

class ContextMenuAddGroup extends ContextMenuBase {
  @override
  late List<ContextMenuItem>? contextItems;
  AppModel appModel;
  TextEditingController groupEditingController = TextEditingController();

  ContextMenuAddGroup(super.title, {required this.appModel});

  @override
  Widget buildContextItemsList(BuildContext context) {
    List<AppsGroup> groups = context.read<ProfileProvider>().appsGroups;

    contextItems = List.empty(growable: true);
    for (AppsGroup group in groups) {
      contextItems!.add(ContextMenuItem(group.groupName, onPressed: () {
        Provider.of<ProfileProvider>(context, listen: false)
            .addAppToGroups(group.id!, appModel);

        Navigator.pop(context);
      }));
    }
    contextItems!.add(ContextMenuItem("Create new group", icon: FluentIcons.add,
        onPressed: () {
      KeyboardOverlay(
        controller: groupEditingController,
        onFinish: (cancel) {
          if (cancel) {
            Navigator.pop(context);
            return;
          }

          context.read<ProfileProvider>().addAppsGroup(AppsGroup(
              groupName: groupEditingController.text, apps: [appModel]));
          Navigator.pop(context);
        },
      ).show(context);
    }));

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
