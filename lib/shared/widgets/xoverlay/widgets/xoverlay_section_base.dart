import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

abstract class XOverlaySectionBase extends StatelessWidget {
  String sectionTitle;
  Widget virtualBuild(BuildContext context);

  XOverlaySectionBase({Key? key, required this.sectionTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 15, 10.0, 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              flex: 0,
              child: Text(
                sectionTitle,
                style: AppTextStyle.XOVERLAY_SECTION_TITLE,
              )),
          const Spacer(),
          Expanded(flex: 20, child: virtualBuild(context))
        ],
      ),
    );
  }
}
