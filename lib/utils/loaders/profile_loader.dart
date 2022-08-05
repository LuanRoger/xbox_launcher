import 'dart:convert';
import 'dart:io';

import 'package:xbox_launcher/models/profile_model.dart';
import 'package:xbox_launcher/shared/app_data_files.dart';
import 'package:xbox_launcher/utils/io_utils.dart';

class ProfileLoader {
  List<ProfileModel> _profileBuffer = List<ProfileModel>.empty(growable: true);
  List<ProfileModel>? get profileBuffer => _profileBuffer;
  int get higherId {
    int tempHigher = 0;

    for (ProfileModel profile in _profileBuffer) {
      if (profile.id > tempHigher) tempHigher = profile.id;
    }

    return tempHigher;
  }

  Future<File> get profileFile async =>
      File(await AppDataFiles.PROFILES_JSON_FILE_PATH);

  Future<bool> loadProfiles() async {
    File file = await profileFile;

    String? profilesText = await IOUtils.readFile(file);

    if (profilesText == null) return false;

    List<dynamic> tempProfileList = json.decode(profilesText);
    _profileBuffer = List<ProfileModel>.from(
        tempProfileList.map((profile) => ProfileModel.fromJson(profile)),
        growable: true);

    return true;
  }

  Future<bool> saveProfile(ProfileModel currentProfile) async {
    int oldProfileIndex =
        _profileBuffer.indexWhere((profile) => profile.id == currentProfile.id);

    if (oldProfileIndex == -1) return false;

    _profileBuffer.removeAt(oldProfileIndex);
    _profileBuffer.insert(oldProfileIndex, currentProfile);

    await saveProfiles();
    return true;
  }

  Future saveProfiles() async {
    JsonEncoder encoder = JsonEncoder.withIndent(' ' * 4);
    String jsonText = encoder
        .convert(_profileBuffer.map((profile) => profile.toJson()).toList());

    await IOUtils.writeFile(jsonText, await profileFile);
  }

  Future addNewProfile(ProfileModel newProfile) async {
    _profileBuffer.add(newProfile);
    await saveProfiles();
  }

  void releaseProfiles() => _profileBuffer.clear();
}
