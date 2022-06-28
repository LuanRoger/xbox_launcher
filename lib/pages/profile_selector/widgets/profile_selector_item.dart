import 'package:fluent_ui/fluent_ui.dart';
import 'package:xbox_launcher/models/profile_model.dart';
import 'package:xbox_launcher/shared/app_text_style.dart';
import 'package:xbox_launcher/shared/widgets/profile_avatar.dart';

class ProfileSelectorItem extends StatelessWidget {
  ProfileModel profileModel;
  FocusNode focusNode = FocusNode();
  void Function() onSelect;

  ProfileSelectorItem(
      {Key? key, required this.profileModel, required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FocusTheme(
          data: FocusThemeData(
              borderRadius: BorderRadius.circular(200),
              glowFactor: 10,
              renderOutside: true),
          child: OutlinedButton(
            style: ButtonStyle(
                border: ButtonState.all(BorderSide.none),
                backgroundColor: ButtonState.all(Colors.transparent),
                padding: ButtonState.all(const EdgeInsets.all(5))),
            focusNode: focusNode,
            onPressed: onSelect,
            child: ProfileAvatar(
              accentColor: profileModel.themePreferences.accentColor,
              profileImagePath: profileModel.profileImagePath,
              radiusSize: 100,
            ),
          ),
        ),
        Text(
          profileModel.name,
          style: AppTextStyle.PROFILE_NAME_SELECTION_ITEM,
        )
      ],
    );
  }
}
