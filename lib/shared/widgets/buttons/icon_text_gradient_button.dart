import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/buttons/icon_text_button.dart';
import 'package:xbox_launcher/shared/widgets/focus/element_focus_node.dart';

class IconTextGradientButton extends StatelessWidget {
  String title;
  void Function() onPressed;
  IconData icon;
  double? width;
  double? height;
  ElementFocusNode? focusNode;
  List<Color> gradientColors;
  List<double>? stops;
  AlignmentGeometry begin;
  AlignmentGeometry end;

  IconTextGradientButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
    required this.gradientColors,
    required this.begin,
    required this.end,
    this.stops,
    this.width,
    this.height,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: gradientColors, begin: begin, end: end, stops: stops)),
      child: IconTextButton(
        title: title,
        onPressed: onPressed,
        icon: icon,
        width: width,
        height: height,
        focusNode: focusNode,
        bigMode: true,
        style:
            ButtonStyle(backgroundColor: ButtonState.all(Colors.transparent)),
      ),
    );
  }
}
