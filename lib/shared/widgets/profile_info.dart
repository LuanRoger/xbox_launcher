import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/profile_avatar.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: ((_, value, __) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileAvatar(
              accentColor: value.accentColor,
              profileImagePath: value.profileImagePath != null
                  ? value.profileImagePath!
                  : null,
            ),
            const SizedBox(width: 5),
            Text(
              value.name,
              style: AppTextStyle.PROFILE_INFO_USER_NAME_TEXT,
            )
          ],
        );
      }),
    );
  }
}
