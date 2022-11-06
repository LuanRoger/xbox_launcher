import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/buttons/models/system_outlined_button.dart';
import 'package:xbox_launcher/shared/widgets/profile_avatar/profile_avatar.dart';

class ProfileAvatarButton extends SystemOutlinedButton {
  final String? profileImagePath;
  Color accentColor;
  double? radiusSize;

  ProfileAvatarButton(
      {super.key,
      required super.onPressed,
      required this.accentColor,
      super.width,
      super.height = 170,
      super.focusNode,
      this.profileImagePath,
      this.radiusSize})
      : super(
          content: ProfileAvatar(
            accentColor: accentColor,
            profileImagePath: profileImagePath,
            radiusSize: 100,
          ),
          style: ButtonStyle(
            backgroundColor: ButtonState.all(Colors.transparent),
            padding: ButtonState.all(
              const EdgeInsets.all(5),
            ),
          ),
        );
}
