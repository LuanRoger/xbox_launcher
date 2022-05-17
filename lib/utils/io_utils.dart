import 'dart:io';

class IOUtils {
  static Future<bool> checkFile(String path) {
    return File(path).exists();
  }

  static Future<String> readFile(String path) {
    File file = File(path);
    return file.readAsString();
  }

  static Future writeFile(String text, String path) {
    File file = File(path);
    return file.writeAsString(text);
  }
}
