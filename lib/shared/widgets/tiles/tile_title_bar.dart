// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_colors.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

class TileTitleBar extends StatefulWidget {
  String title;

  TileTitleBar(this.title, {Key? key}) : super(key: key);

  @override
  State<TileTitleBar> createState() => _TileTitleBarState();
}

class _TileTitleBarState extends State<TileTitleBar> {
  late final double maxHeight;
  final Duration animationDuration = const Duration(milliseconds: 500);

  double getHeightOnTitle() {
    int titleLenght = widget.title.length;

    if (titleLenght >= 0 && titleLenght <= 23)
      return 23.0;
    else if (titleLenght > 23 && titleLenght <= 40)
      return 40.0;
    else if (titleLenght > 40 && titleLenght <= 60) return 60.0;

    return double.infinity;
  }

  @override
  void initState() {
    super.initState();
    maxHeight = getHeightOnTitle();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: animationDuration,
      tween: Tween<double>(begin: 0, end: maxHeight),
      curve: Curves.easeOutQuart,
      builder: (_, double height, __) {
        return Container(
          color: AppColors.ELEMENT_BG.withOpacity(0.5),
          width: double.infinity,
          height: height,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.title,
                  style: AppTextStyle.XBOX_GAME_BUTTON_TITLE)),
        );
      },
    );
  }
}
