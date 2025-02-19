import 'package:url_launcher/url_launcher.dart';

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
