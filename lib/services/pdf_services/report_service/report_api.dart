import 'dart:convert';
import 'package:http/http.dart' as http;

class ReportApiService {
  static Future<Map<String, dynamic>?> reportAnalysisApi(String label, double confidence) async {
    var url = Uri.parse("https://instascanreport.onrender.com/analyze");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "label": label,
          "confidence": confidence,
        }),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded["status"] == "success") {
          return decoded["data"]; // Contains riskLevel, description, suggestions, explanation
        }
      } else {
        print("Failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }

    return null;
  }
}