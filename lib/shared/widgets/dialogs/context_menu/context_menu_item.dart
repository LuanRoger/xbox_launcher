import 'package:fluent_ui/fluent_ui.dart';

class ContextMenuItem extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function() onPressed;

  const ContextMenuItem(this.text,
      {super.key, required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return Button(
        style: ButtonStyle(
            border: ButtonState.all(BorderSide.none),
            padding: ButtonState.all(
                const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0)),
            backgroundColor: ButtonState.all(Colors.transparent),
            shadowColor: ButtonState.all(Colors.transparent)),
        child: Row(children: [
          Icon(icon),
          const SizedBox(width: 10),
          Text(
            text,
            overflow: TextOverflow.fade,
          )
        ]),
        onPressed: onPressed);
  }
}
