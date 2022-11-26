import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/app_models/app_model.dart';
import 'package:xbox_launcher/models/apps_group.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/keyboard/keyboard_overlay.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu_base.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu_item.dart';

class ContextMenuAddGroup extends ContextMenuBase {
  @override
  // ignore: overridden_fields
  late List<ContextMenuItem>? contextItems;
  AppModel appModel;
  TextEditingController groupEditingController = TextEditingController();

  ContextMenuAddGroup(super.title, {required this.appModel});

  @override
  Widget buildContextItemsList(BuildContext context) {
    List<ContextMenuItem> groupsItems = List.empty(growable: true);
    final groups = context.read<ProfileProvider>().appsGroups;

    for (AppsGroup group in groups) {
      groupsItems.add(ContextMenuItem(group.groupName, onPressed: () {
        context.read<ProfileProvider>().addAppToGroups(group.id!, appModel);

        Navigator.pop(context);
      }));
    }
    groupsItems.add(ContextMenuItem("Create new group", icon: FluentIcons.add,
        onPressed: () async {
      final groupEditingController = TextEditingController();
      final keyboardHandler = KeyboardOverlay(
        controller: groupEditingController,
        context: context,
        onFinish: (cancel) {
          if (cancel) {
            Navigator.pop(context);
            return;
          }

          context.read<ProfileProvider>().addNewGroup(AppsGroup(
              groupName: groupEditingController.text, apps: [appModel]));
          Navigator.pop(context);
        },
      );

      await keyboardHandler.show();
      keyboardHandler.dispose();
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
