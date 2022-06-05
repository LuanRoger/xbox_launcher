import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/profile_avatar.dart';

class NavigationBarProfile extends StatelessWidget {
  IconData icon;

  NavigationBarProfile(this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Flexible(child: Icon(icon)),
        const Spacer(),
        Flexible(
            flex: 10,
            child: Consumer<ProfileProvider>(
              builder: (_, value, __) => ProfileAvatar(
                accentColor: value.accentColor,
                profileImagePath: value.profileImagePath != null
                    ? value.profileImagePath!
                    : null,
              ),
            )),
        const SizedBox(
          width: 5,
        ),
        Expanded(
            flex: 0,
            child: Consumer<ProfileProvider>(
              builder: (_, value, __) => Text(
                value.name,
                overflow: TextOverflow.fade,
                style: AppTextStyle.PROFILE_INFO_USER_NAME_TEXT,
              ),
            ))
      ]),
    );
  }
}
