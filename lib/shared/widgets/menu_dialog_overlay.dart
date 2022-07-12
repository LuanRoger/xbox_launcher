import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

class MenuDialogOverlay {
  String title;
  Widget content;
  final List<Widget>? actions;

  MenuDialogOverlay(this.title,
      {Key? key, required this.content, this.actions});

  void show(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    showGeneralDialog(
        context: context,
        pageBuilder: (buildContext, _, __) {
          return Align(
            alignment: Alignment.center,
            child: Container(
                width: double.infinity,
                height: screenHeight * 0.8,
                color: AppColors.DARK_BG,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 30, 5, 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyle.MENU_DIALOG_TITLE,
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: content,
                      )),
                      actions != null
                          ? Row(
                              children: actions!,
                            )
                          : const SizedBox()
                    ],
                  ),
                )),
          );
        });
  }
}
