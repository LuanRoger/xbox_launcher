import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:xbox_launcher/models/profile_model.dart';
import 'package:xbox_launcher/providers/profile_provider.dart';

class Background extends StatelessWidget {
  final ProfileModel? profileModel;

  const Background({Key? key, this.profileModel}) : super(key: key);

  Widget _generateColorBackground(Color color) => Container(color: color);
  Widget _generateImageBackground(String imagePath) =>
      Image.file(File(imagePath), fit: BoxFit.cover);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: profileModel != null
          ? profileModel!.backgroundPreferences.preferenceByImage
              ? _generateImageBackground(
                  profileModel!.backgroundPreferences.imageBackgroundPath!)
              : _generateColorBackground(
                  profileModel!.backgroundPreferences.solidColorBackground)
          : Consumer<ProfileProvider>(
              builder: (_, value, __) {
                return value.preferenceByImage
                    ? _generateImageBackground(value.imageBackgroundPath!)
                    : _generateColorBackground(value.solidColorBackground);
              },
            ),
    );
  }
}
