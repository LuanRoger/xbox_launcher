import 'package:file_picker/file_picker.dart';

class ExternalFilePicker {
  Future<String?> getImagePath({String dialogTitle = "Select Image"}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false, type: FileType.image, dialogTitle: dialogTitle);

    return result?.files.single.path;
  }
}
