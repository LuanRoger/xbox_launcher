import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

class WellcomingMessage extends StatelessWidget {
  const WellcomingMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Wellcome.",
          style: AppTextStyle.PLACEHOLDER_MESSAGE_TITLE,
        ),
        Text(
          "Go to configurations to setup and start to use.",
          style: AppTextStyle.PLACEHOLDER_SUBMESSAGE_TEXT,
        )
      ],
    );
  }
}
