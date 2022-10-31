import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

class NoGroupsMessage extends StatelessWidget {
  const NoGroupsMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "No Groups created.",
      style: AppTextStyle.PLACEHOLDER_MESSAGE_TITLE,
    );
  }
}
