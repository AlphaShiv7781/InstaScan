import 'dart:io';
import 'package:flutter/services.dart' as flutter_services;
import 'dart:typed_data' as typed_data;
import 'package:instascan/services/pdf_services/cloudinary_pdf_upload.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class PDFService {
  Future<String?> generatePDF({
    required File patientImageFile,
    required File reportImageFile,
    required String patientName,
    required String patientAge,
    required String patientGender,
    required String patientEmail,
    required String patientMobile,
    required String confidenceScore,
  }) async {
    final pdf = pw.Document();

    // Load logo from assets
    final typed_data.ByteData logoData = await flutter_services.rootBundle.load('assets/images/Logo.png');
    final typed_data.Uint8List logoBytes = logoData.buffer.asUint8List();

    // Read image files as Uint8List
    final typed_data.Uint8List patientImage = await patientImageFile.readAsBytes();
    final typed_data.Uint8List reportImage = await reportImageFile.readAsBytes();

    // Load custom font (optional)
    final pw.Font roboto = pw.Font.ttf(await flutter_services.rootBundle.load("assets/fonts/Roboto-Regular.ttf"));

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(24),
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.black, width: 1),
            ),
            padding: pw.EdgeInsets.all(16),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                // Logo
                pw.Image(pw.MemoryImage(logoBytes), height: 120),

                pw.SizedBox(height: 40),

                // Title
                pw.Text(
                  "SKIN CANCER ASSESSMENT REPORT",
                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, font: roboto),
                  textAlign: pw.TextAlign.center,
                ),

                pw.SizedBox(height: 60),

                // Images Section
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    // Patient Image
                    pw.Column(
                      children: [
                        pw.Container(
                          height: 120,
                          width: 120,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(color: PdfColors.black),
                          ),
                          child: pw.Image(pw.MemoryImage(patientImage)),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text("Patient Image", style: pw.TextStyle(fontSize: 10, font: roboto)),
                      ],
                    ),

                    // Medical Report Image
                    pw.Column(
                      children: [
                        pw.Container(
                          height: 120,
                          width: 120,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(color: PdfColors.black),
                          ),
                          child: pw.Image(pw.MemoryImage(reportImage)),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text("Medical Report Image", style: pw.TextStyle(fontSize: 10, font: roboto)),
                      ],
                    ),
                  ],
                ),

                pw.SizedBox(height: 50),

                // Patient Details Section
                pw.Padding(
                    padding: pw.EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: pw.Container(
                  width: double.infinity,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black),
                  ),
                  padding: pw.EdgeInsets.all(10),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Patient Name :-  $patientName", style: pw.TextStyle(font: roboto, fontSize: 12)),
                      pw.Text("Patient Age :-  $patientAge", style: pw.TextStyle(font: roboto, fontSize: 12)),
                      pw.Text("Patient Gender :-  $patientGender", style: pw.TextStyle(font: roboto, fontSize: 12)),
                      pw.Text("Patient Email :-  $patientEmail", style: pw.TextStyle(font: roboto, fontSize: 12)),
                      pw.Text("Patient MobileNo. :-  $patientMobile", style: pw.TextStyle(font: roboto, fontSize: 12)),
                    ],
                  ),
                ),
          ),

                pw.SizedBox(height: 50),

                // Confidence Score Box
                pw.Container(
                  padding: pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black),
                  ),
                  child: pw.Text(
                    "Confidence Score for Skin Cancer ⇒  $confidenceScore",
                    style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, font: roboto),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    // Save the PDF file to temp directory
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/skin_cancer_report.pdf");
    await file.writeAsBytes(await pdf.save());

      CloudinaryService cloudinaryService = CloudinaryService();
      String? url = await cloudinaryService.uploadPDF(file);

    return url;
  }

}
