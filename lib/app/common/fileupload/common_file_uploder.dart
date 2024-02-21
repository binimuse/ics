import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:ics/utils/constants.dart';
import 'package:mime/mime.dart';

class MinioUploader {
  Future<String> uploadFileToMinio(
      PlatformFile file, String documentTypeId) async {
    var uploadUrl = Uri.parse(Constants.fileUploader);
    var request = http.MultipartRequest('POST', uploadUrl);
    final mimeType = lookupMimeType(file.path!);

    request.files.add(http.MultipartFile(
      'file',
      File(file.path!).openRead(),
      await File(file.path!).length(),
      filename: file.name,
      contentType: MediaType.parse(mimeType ?? 'application/octet-stream'),
    ));

    var response = await request.send();

    if (response.statusCode == 201) {
      // Check for 201 status code
      var responseBody = await response.stream.bytesToString();
      Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
      String url = jsonResponse['url'];
      print(jsonResponse);

      return url;
    } else {
      print(response.reasonPhrase);
      throw Exception('Failed to upload file: ${response.reasonPhrase}');
    }
  }
}
