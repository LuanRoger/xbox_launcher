import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

class VolumesErrorMessage extends StatelessWidget {
  const VolumesErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Was no possible to get the volumes informations.",
      style: AppTextStyle.PLACEHOLDER_MESSAGE_TITLE,
    );
  }
}
