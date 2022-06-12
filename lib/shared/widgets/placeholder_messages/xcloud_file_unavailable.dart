import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

class XCloudFileUnavailable extends StatelessWidget {
  const XCloudFileUnavailable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "No XCloud games file setedup.",
          style: AppTextStyle.PLACEHOLDER_MESSAGE_TITLE,
        ),
        Text(
          "Go to configurations to setup.",
          style: AppTextStyle.PLACEHOLDER_SUBMESSAGE_TEXT,
        )
      ],
    );
  }
}
