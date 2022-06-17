import 'dart:io';

import 'package:path_provider/path_provider.dart';

class AppDataFiles {
  static Future<Directory> get BASE_DIRECTORY async {
    Directory baseDirectory = Directory(
        (await getApplicationDocumentsDirectory()).path + "\\xbox_launcher");
    if (!await baseDirectory.exists()) {
      await baseDirectory.create();
    }

    return baseDirectory;
  }

  static Future<String> get PROFILES_JSON_FILE_PATH async {
    return (await BASE_DIRECTORY).path + "\\profiles_data.json";
  }
}
