import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xbox_launcher/models/profile_model.dart';
import 'package:xbox_launcher/providers/profile_providers.dart';

class Background extends ConsumerWidget {
  final ProfileModel? profileModel;

  const Background({Key? key, this.profileModel}) : super(key: key);

  Widget _generateColorBackground(Color color) => Container(color: color);
  Widget _generateImageBackground(String imagePath) =>
      Image.file(File(imagePath), fit: BoxFit.cover);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backgroundPreferences =
        ref.watch(backgroundProfilePreferencesProvider);

    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: profileModel != null
            ? profileModel!.backgroundPreferences.preferenceByImage
                ? _generateImageBackground(
                    profileModel!.backgroundPreferences.imageBackgroundPath!)
                : _generateColorBackground(
                    profileModel!.backgroundPreferences.solidColorBackground)
            : backgroundPreferences.preferenceByImage
                ? _generateImageBackground(
                    backgroundPreferences.imageBackgroundPath!)
                : _generateColorBackground(
                    backgroundPreferences.solidColorBackground));
  }
}
