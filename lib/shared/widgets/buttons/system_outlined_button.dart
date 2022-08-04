import 'package:fluent_ui/fluent_ui.dart';

class SystemOutlinedButton extends OutlinedButton {
  Widget content;
  double? height;
  double? width;

  SystemOutlinedButton(
      {Key? key,
      required this.content,
      required void Function() onPressed,
      this.width = 170.0,
      this.height = 70.0})
      : super(
            key: key,
            child: SizedBox(
              width: width,
              height: height,
              child: content,
            ),
            onPressed: onPressed,
            style: ButtonStyle(border: ButtonState.all(BorderSide.none)));
}
