import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';


void openPDF(String pdfUrl) async {
  if (pdfUrl.isEmpty) {
    print("Error: PDF URL is empty.");
    return;
  }

  Uri uri = Uri.parse(pdfUrl);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    print("Could not open PDF: $pdfUrl");
  }
}

Future<void> downloadAndOpenPDF(String pdfUrl) async {
  if (pdfUrl.isEmpty) {
    print("Error: PDF URL is empty.");
    return;
  }

  try {
    // Get the app's document directory
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = "${directory.path}/downloaded.pdf";

    // Download the PDF file
    Dio dio = Dio();
    await dio.download(pdfUrl, filePath);

    // Open the downloaded PDF
    await OpenFilex.open(filePath);
  } catch (e) {
    print("Error downloading or opening PDF: $e");
  }
}