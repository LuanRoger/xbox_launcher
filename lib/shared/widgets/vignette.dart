import 'package:fluent_ui/fluent_ui.dart';

class Vignette extends StatelessWidget {
  Color color;
  double? width;
  double? height;

  Vignette({Key? key, this.color = Colors.black, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.black, Colors.transparent])),
    );
  }
}
