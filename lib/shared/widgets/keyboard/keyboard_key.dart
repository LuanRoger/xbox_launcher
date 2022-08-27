import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_colors.dart';

class KeyboardKey extends StatelessWidget {
  final String text;
  final ImageProvider? buttonImage;
  final void Function() onKeyPress;

  const KeyboardKey(
      {Key? key,
      required this.text,
      required this.onKeyPress,
      this.buttonImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            buttonImage != null
                ? Image(
                    image: buttonImage!,
                    width: 25,
                    height: 25,
                  )
                : const SizedBox()
          ],
        ),
      ),
      onPressed: onKeyPress,
      style: ButtonStyle(
          shape: ButtonState.all(
              const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
          backgroundColor: ButtonState.all(AppColors.ELEMENT_DARK_BG)),
    );
  }
}
