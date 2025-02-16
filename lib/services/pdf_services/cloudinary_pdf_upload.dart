import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CloudinaryService {
  final String cloudName = "dnhp56mgv";
  final String apiKey = "187641341724696";
  final String apiSecret = "PSC6pp38adXyTyrZG6l62Pr4jMs";
  final String uploadPreset = "ml_default"; // If using unsigned upload

  // Upload PDF to Cloudinary
  Future<String?> uploadPDF(File pdfFile) async {
    final url = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/upload");

    // Create a multipart request
    final request = http.MultipartRequest("POST", url)
      ..fields['upload_preset'] = uploadPreset  // Required for unsigned uploads
      ..fields['resource_type'] = 'raw'  // Ensure Cloudinary treats it as a file
      ..files.add(await http.MultipartFile.fromPath("file", pdfFile.path));

    final response = await request.send();

    // Parse response
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseData);
      return jsonResponse["secure_url"]; // Get the Cloudinary file URL
    } else {
      print("Upload Failed: ${response.reasonPhrase}");
      return null;
    }
  }

  void testUpload() async {
    final cloudinaryService = CloudinaryService();
    final File pdfFile = File("path/to/sample.pdf");  // Replace with a real PDF path

    String? uploadedURL = await cloudinaryService.uploadPDF(pdfFile);

    if (uploadedURL != null) {
      print("PDF uploaded successfully: $uploadedURL");
    } else {
      print("Failed to upload PDF.");
    }
  }

}
