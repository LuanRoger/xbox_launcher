import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:xbox_launcher/models/profile_model.dart';
import 'package:xbox_launcher/shared/app_data_files.dart';
import 'package:xbox_launcher/utils/io_utils.dart';

class ProfileLoader {
  List<ProfileModel>? _profileBuffer;
  List<ProfileModel>? get profileBuffer => _profileBuffer;
  Future<File> get profileFile async =>
      File(await AppDataFiles.PROFILES_JSON_FILE_PATH);

  Future<bool> loadProfiles() async {
    File file = await profileFile;

    String? profilesText = await IOUtils.readFile(file);

    if (profilesText == null) return false;

    List<dynamic> tempProfileList = json.decode(profilesText);
    _profileBuffer = List<ProfileModel>.from(
        tempProfileList.map((profile) => ProfileModel.fromJson(profile)));

    return true;
  }

  Future<bool> saveProfile(ProfileModel currentProfile) async {
    int oldProfileIndex = _profileBuffer!
        .indexWhere((profile) => profile.name == currentProfile.name);

    if (oldProfileIndex == -1) return false;

    _profileBuffer!.removeAt(oldProfileIndex);
    _profileBuffer!.insert(oldProfileIndex, currentProfile);

    await saveProfiles();
    return true;
  }

  Future saveProfiles() async {
    JsonEncoder encoder = JsonEncoder.withIndent(' ' * 4);
    String jsonText = encoder
        .convert(_profileBuffer!.map((profile) => profile.toJson()).toList());

    await IOUtils.writeFile(jsonText, await profileFile);
  }

  Future createDefaultProfile(ProfileModel defaultProfile) async {
    _profileBuffer = [defaultProfile];
    await saveProfiles();
  }

  void releaseProfiles() => _profileBuffer = null;
}
