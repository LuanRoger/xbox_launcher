import 'package:flutter/material.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/dialogs/context_menu/context_menu_item.dart';

class ContextMenu {
  final String title;
  final List<ContextMenuItem> contextItems;

  const ContextMenu(this.title, {required this.contextItems});

  Future show(BuildContext context) async {
    final size = MediaQuery.of(context).size;

    await showDialog(
        context: context,
        builder: (_) => Dialog(
              backgroundColor: Colors.transparent,
              alignment: Alignment.center,
              child: Container(
                width: size.width * 0.2,
                padding:
                    const EdgeInsets.only(top: 20.0, left: 1.0, right: 1.0),
                decoration: BoxDecoration(
                    color: AppColors.ELEMENT_BG,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
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
                        ),
                      )),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) => contextItems[index],
                            itemCount: contextItems.length,
                            separatorBuilder: (_, __) => const SizedBox(
                                  height: 8.0,
                                )),
                      )
                    ]),
              ),
            ));
  }
}
