import 'dart:io';

class IOUtils {
  ///Read and return the content of an file.
  ///If the file not exist, will return null.
  static Future<String?> readFile(String path) async {
    File file = File(path);
    if (!(await file.exists())) return null;

    return await file.readAsString();
  }

  static Future writeFile(String text, String path) async {
    File file = File(path);
    return await file.writeAsString(text, mode: FileMode.write);
  }
}
