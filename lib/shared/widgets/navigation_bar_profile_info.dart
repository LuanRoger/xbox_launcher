import 'package:fluent_ui/fluent_ui.dart';

class NavigationBarProfile extends StatelessWidget {
  IconData icon;

  NavigationBarProfile(this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Flexible(child: Icon(icon)),
        const Spacer(),
        Flexible(
          flex: 10  ,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 40,
                color: Colors.green,
              )),
        ),
        const SizedBox(
          width: 5,
        ),
        const Expanded(
            flex: 0,
            child: Text(
              "ProfilePlaceholder",
              overflow: TextOverflow.fade,
            ))
      ]),
    );
  }
}
