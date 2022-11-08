// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as P;

class AppDataFiles {
  static Future<Directory> get baseDirectory async {
    String documentsDirectoryPath =
        (await getApplicationDocumentsDirectory()).path;
    Directory baseDirectory =
        Directory(P.join(documentsDirectoryPath, "xbox_launcher"));

    if (!await baseDirectory.exists()) {
      await baseDirectory.create();
    }

    return baseDirectory;
  }

  static Future<String> get profilesJsonFilePath async {
    String baseDirectoryPath = (await baseDirectory).path;

    return P.join(baseDirectoryPath, "profiles_data.json");
  }
}
