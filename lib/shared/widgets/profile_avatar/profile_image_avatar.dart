import 'package:fluent_ui/fluent_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xbox_launcher/providers/profile_providers.dart';
import 'package:xbox_launcher/shared/widgets/profile_avatar/profile_avatar.dart';

class ProfileImageAvatar extends ConsumerWidget {
  final double? radiusSize;

  const ProfileImageAvatar({Key? key, this.radiusSize}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileTheme = ref.watch(profileThemeProvider);
    final profileInfo = ref.watch(currentProfileProvider);

    return ProfileAvatar(
      accentColor: profileTheme.accentColor,
      radiusSize: radiusSize,
      profileImagePath: profileInfo.profileImagePath != null
          ? profileInfo.profileImagePath!
          : null,
    );
  }
}
