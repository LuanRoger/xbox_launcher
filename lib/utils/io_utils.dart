import 'dart:io';

class IOUtils {
  static Future<bool> checkFile(String path) {
    return File(path).exists();
  }

  ///Read and return the content of an file.
  ///If the file not exist, will return null.
  static Future<String?> readFile(String path) async {
    if (!(await checkFile(path))) return null;

    File file = File(path);
    return file.readAsString();
  }

  static Future writeFile(String text, String path) async {
    File file = File(path);
    return file.writeAsString(text, mode: FileMode.write);
  }
}
