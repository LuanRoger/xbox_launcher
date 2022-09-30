import 'package:flutter/material.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu_base.dart';

class ContextMenu extends ContextMenuBase {
  ContextMenu(super.title, {super.contextItems});

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
