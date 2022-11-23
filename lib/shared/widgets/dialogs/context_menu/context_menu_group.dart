import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/apps_group.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/keyboard/keyboard_overlay.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu_base.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu_item.dart';

class ContextMenuGroup extends ContextMenuBase {
  @override
  // ignore: overridden_fields
  late List<ContextMenuItem>? contextItems;
  final AppsGroup group;
  final TextEditingController renameController = TextEditingController();

  ContextMenuGroup(this.group) : super(group.groupName);

  @override
  Widget buildContextItemsList(BuildContext context) {
    contextItems = List.empty(growable: true);

    contextItems!.addAll([
      ContextMenuItem("Rename group", icon: FluentIcons.rename,
          onPressed: () async {
        final keyboardHandler = KeyboardOverlay(
          controller: renameController,
          onFinish: (cancel) {
            if (cancel) {
              Navigator.pop(context);
              return;
            }

            context
                .read<ProfileProvider>()
                .renameGroup(group.id!, renameController.text);
            renameController.clear();
            Navigator.pop(context);
          },
        );
        await keyboardHandler.show(context);

        keyboardHandler.dispose();
      }),
      ContextMenuItem("Remove group", icon: FluentIcons.remove_content,
          onPressed: () {
        context.read<ProfileProvider>().removeGroup(group.id!);

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
            Consumer(
              builder: (context, ref, _) => buildContextItemsList(context),
            )
          ]);
}
