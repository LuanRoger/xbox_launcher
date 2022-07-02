import 'package:file_picker/file_picker.dart';

class ExternalFilePicker {
  static Future<String?> getImagePath(
      {String dialogTitle = "Select Image"}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false, type: FileType.image, dialogTitle: dialogTitle);

    return result?.files.single.path;
  }

  static Future<String?> getJsonPath(
      {String dialogTitle = "Select JSON File"}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        allowCompression: true,
        withReadStream: true,
        allowedExtensions: [".json"],
        type: FileType.custom,
        dialogTitle: dialogTitle);

    return result?.files.single.path;
  }
}
