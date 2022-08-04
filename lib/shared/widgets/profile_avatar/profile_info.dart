import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/profile_avatar/profile_image_avatar.dart';

class ProfileInfo extends StatelessWidget {
  double? radiusSize;
  TextStyle? textStyle;

  ProfileInfo({Key? key, this.radiusSize, this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: ((_, value, __) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileImageAvatar(
              radiusSize: radiusSize,
            ),
            const SizedBox(width: 5),
            Text(
              value.name,
              style: textStyle ?? AppTextStyle.PROFILE_INFO_USER_NAME_TEXT,
            )
          ],
        );
      }),
    );
  }
}
