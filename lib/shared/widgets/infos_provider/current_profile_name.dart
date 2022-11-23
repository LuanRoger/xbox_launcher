import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/profile_preview_elements_preferences.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';

class CurrentProfileName extends StatelessWidget {
  final TextOverflow textOverflow;

  const CurrentProfileName({super.key, this.textOverflow = TextOverflow.fade});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (_, value, __) => Text(
        value.name,
        overflow: textOverflow,
        style: AppTextStyle.PROFILE_INFO_USER_NAME_TEXT,
      ),
    );
  }
}
