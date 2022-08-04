import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/shared/widgets/profile_avatar/profile_avatar.dart';

class ProfileAvatarButton extends StatelessWidget {
  void Function() onPressed;
  Color accentColor;
  FocusNode? focusNode;
  String? profileImagePath;
  double? radiusSize;

  ProfileAvatarButton(
      {Key? key,
      required this.onPressed,
      required this.accentColor,
      this.focusNode,
      this.profileImagePath,
      this.radiusSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
          border: ButtonState.all(BorderSide.none),
          backgroundColor: ButtonState.all(Colors.transparent),
          padding: ButtonState.all(const EdgeInsets.all(5))),
      focusNode: focusNode,
      onPressed: onPressed,
      child: ProfileAvatar(
        accentColor: accentColor,
        profileImagePath: profileImagePath,
        radiusSize: 100,
      ),
    );
  }
}
