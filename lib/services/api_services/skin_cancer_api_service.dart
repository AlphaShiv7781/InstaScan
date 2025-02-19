import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
class SkinCancerApiService{

  static Future<String?> skinCancerApi(File skinLesion) async {
    var url = Uri.parse("https://skin-cancer-model-api.onrender.com/predict");

    try {
      var request = http.MultipartRequest("POST", url)
        ..files.add(
          http.MultipartFile(
            'file',
            skinLesion.readAsBytes().asStream(),
            skinLesion.lengthSync(),
            filename: basename(skinLesion.path),
          ),
        );

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print("Raw Response: $responseBody");
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
        print("Parsed JSON: $jsonResponse");

        return jsonResponse['disease_confidence'] as String?;
      } else {
        print("Error: ${response.statusCode} - $responseBody");
      }
    } catch (e) {
      print("Exception: $e");
    }
    return null;
  }

}