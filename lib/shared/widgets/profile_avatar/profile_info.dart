import 'package:fluent_ui/fluent_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xbox_launcher/providers/profile_providers.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/profile_avatar/profile_image_avatar.dart';

class ProfileInfo extends ConsumerWidget {
  final double? radiusSize;
  final TextStyle? textStyle;

  const ProfileInfo({Key? key, this.radiusSize, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileInfo = ref.watch(currentProfileProvider);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfileImageAvatar(
          radiusSize: radiusSize,
        ),
        const SizedBox(width: 5),
        Text(
          profileInfo.name,
          style: textStyle ?? AppTextStyle.PROFILE_INFO_USER_NAME_TEXT,
        )
      ],
    );
  }
}
