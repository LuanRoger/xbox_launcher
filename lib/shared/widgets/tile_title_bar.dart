import 'package:fluent_ui/fluent_ui.dart';

import '../app_text_style.dart';

class TileTitleBar extends StatelessWidget {
  String title;

  TileTitleBar(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(59, 58, 59, 0.5),
      width: double.infinity,
      height: 25,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            Text(title, style: AppTextStyle.XBOX_GAME_BUTTON_TITLE),
          ],
        ),
      ),
    );
  }
}
