import 'package:fluent_ui/fluent_ui.dart';

import '../app_text_style.dart';

class TileTitleBar extends StatefulWidget {
  String title;

  TileTitleBar(this.title, {Key? key}) : super(key: key);

  @override
  State<TileTitleBar> createState() => _TileTitleBarState();
}

class _TileTitleBarState extends State<TileTitleBar> {
  final double maxHeight = 25;
  final Duration animationDuration = const Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: animationDuration,
      tween: Tween<double>(begin: 0, end: maxHeight),
      curve: Curves.easeOutQuart,
      builder: (_, double height, __) {
        return Container(
          color: const Color.fromRGBO(59, 58, 59, 0.5),
          width: double.infinity,
          height: height,
          child: Align(
              alignment:
                  height == maxHeight/2 ? Alignment.bottomLeft : Alignment.centerLeft,
              child: Text(widget.title,
                  style: AppTextStyle.XBOX_GAME_BUTTON_TITLE)),
        );
      },
    );
  }
}
