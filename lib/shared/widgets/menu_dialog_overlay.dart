import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

class MenuDialogOverlay {
  String title;
  Widget content;
  final List<Widget> actions;

  MenuDialogOverlay(this.title,
      {Key? key, required this.actions, required this.content});

  void show(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext buildContext, Animation<double> animation,
            Animation<double> secundatyAnimation) {
          return Align(
            alignment: Alignment.center,
            child: Container(
                width: double.infinity,
                height: screenHeight * 0.7,
                color: AppColors.DARK_BG,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 50, 5, 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyle.MENU_DIALOG_TITLE,
                      ),
                      content,
                      Row(
                        children: actions,
                      )
                    ],
                  ),
                )),
          );
        });
  }
}
