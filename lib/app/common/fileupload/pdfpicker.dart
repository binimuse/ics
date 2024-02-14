
import 'package:file_picker/file_picker.dart';


class PdfPicker {
  static Future<PlatformFile?> pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      if (file.extension == 'pdf') {
        int fileSize = file.size;

        if (fileSize <= 10 * 1024 * 1024) {
          return file;
        } else {
          throw Exception("File size exceeds the limit of 10MB!");
        }
      } else {
        throw Exception("Invalid File!!");
      }
    } else {
      throw Exception("File Not picked!!");
    }
  }
}
