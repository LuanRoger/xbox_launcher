import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/widgets/profile_avatar/profile_avatar.dart';

class ProfileImageAvatar extends StatelessWidget {
  final double? radiusSize;

  const ProfileImageAvatar({Key? key, this.radiusSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (_, value, __) => ProfileAvatar(
        accentColor: value.accentColor,
        radiusSize: radiusSize,
        profileImagePath:
            value.profileImagePath != null ? value.profileImagePath! : null,
      ),
    );
  }
}
