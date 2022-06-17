import 'dart:io';

class IOUtils {
  ///Read and return the content of an file.
  ///If the file not exist, will return null.
  static Future<String?> readFile(File file) async {
    if (!(await file.exists())) return null;

    return await file.readAsString();
  }

  static Future writeFile(String text, File file) async {
    await file.writeAsString(text, mode: FileMode.write, flush: true);
  }
}
