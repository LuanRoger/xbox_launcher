import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/profile_model.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';

class Background extends StatelessWidget {
  ProfileModel? profileModel;

  Background({Key? key, this.profileModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return profileModel != null
        ? profileModel!.backgroundPreferences.preferenceByImage &&
                profileModel!.backgroundPreferences.imageBackgroundPath != null
            ? Image.file(
                File(profileModel!.backgroundPreferences.imageBackgroundPath!),
                fit: BoxFit.cover)
            : Container(
                color: profileModel!.backgroundPreferences.solidColorBackground,
              )
        : Consumer<ProfileProvider>(
            builder: (_, value, __) {
              return value.preferenceByImage &&
                      value.imageBackgroundPath != null
                  ? Image.file(File(value.imageBackgroundPath!),
                      fit: BoxFit.cover)
                  : Container(
                      color: value.solidColorBackground,
                    );
            },
          );
  }
}
