import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
class PneumoniaApiService{

  static Future<String?> pneumoniaApi(File chestXray) async {
    var url = Uri.parse("https://skin-cancer-model-api.onrender.com/predictPneumonia");

    try {
      var request = http.MultipartRequest("POST", url)
        ..files.add(
          http.MultipartFile(
            'file',
            chestXray.readAsBytes().asStream(),
            chestXray.lengthSync(),
            filename: basename(chestXray.path),
          ),
        );

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print("Raw Response: $responseBody");
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
        print("Parsed JSON: $jsonResponse");

        return jsonResponse['disease-confidence'] as String?;
      } else {
        print("Error: ${response.statusCode} - $responseBody");
      }
    } catch (e) {
      print("Exception: $e");
    }
    return null;
  }

}