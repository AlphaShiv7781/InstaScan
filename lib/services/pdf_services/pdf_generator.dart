import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart' as flutter_services;
import 'dart:typed_data' as typed_data;
import 'package:instascan/services/pdf_services/cloudinary_pdf_upload.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
//
// class PDFService {
//   Future<String?> generatePDF({
//     required String testType,
//     required File patientImageFile,
//     required File reportImageFile,
//     required String patientName,
//     required String patientAge,
//     required String patientGender,
//     required String patientEmail,
//     required String patientMobile,
//     required String confidenceScore,
//     required String riskLevel,
//     required String description,
//     required List<String> suggestion,
//     required String explanation,
//   }) async {
//     final pdf = pw.Document();
//
//     // Load logo from assets
//     final typed_data.ByteData logoData = await flutter_services.rootBundle.load('assets/images/Logo.png');
//     final typed_data.Uint8List logoBytes = logoData.buffer.asUint8List();
//
//     // Read image files as Uint8List
//     final typed_data.Uint8List patientImage = await patientImageFile.readAsBytes();
//     final typed_data.Uint8List reportImage = await reportImageFile.readAsBytes();
//
//     // Load custom font (optional)
//     final pw.Font roboto = pw.Font.ttf(await flutter_services.rootBundle.load("assets/fonts/Roboto-Regular.ttf"));
//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         margin: pw.EdgeInsets.all(24),
//         build: (pw.Context context) {
//           return pw.Container(
//             decoration: pw.BoxDecoration(
//               border: pw.Border.all(color: PdfColors.black, width: 1),
//             ),
//             padding: pw.EdgeInsets.all(16),
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.center,
//               children: [
//                 // Logo
//                 pw.Image(pw.MemoryImage(logoBytes), height: 120),
//
//                 pw.SizedBox(height: 20),
//
//                 // Title
//                 pw.Text(
//                   "$testType ASSESSMENT REPORT",
//                   style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, font: roboto),
//                   textAlign: pw.TextAlign.center,
//                 ),
//
//                 pw.SizedBox(height: 20),
//
//                 // Images Section
//                 pw.Row(
//                   mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
//                   children: [
//                     // Patient Image
//                     pw.Column(
//                       children: [
//                         pw.Container(
//                           height: 80,
//                           width: 80,
//                           decoration: pw.BoxDecoration(
//                             border: pw.Border.all(color: PdfColors.black),
//                           ),
//                           child: pw.Image(pw.MemoryImage(patientImage)),
//                         ),
//                         pw.SizedBox(height: 10),
//                         pw.Text("Patient Image", style: pw.TextStyle(fontSize: 10, font: roboto)),
//                       ],
//                     ),
//
//                     // Medical Report Image
//                     pw.Column(
//                       children: [
//                         pw.Container(
//                           height: 80,
//                           width: 80,
//                           decoration: pw.BoxDecoration(
//                             border: pw.Border.all(color: PdfColors.black),
//                           ),
//                           child: pw.Image(pw.MemoryImage(reportImage)),
//                         ),
//                         pw.SizedBox(height: 10),
//                         pw.Text("Medical Report Image", style: pw.TextStyle(fontSize: 10, font: roboto)),
//                       ],
//                     ),
//                   ],
//                 ),
//
//                 pw.SizedBox(height: 20),
//
//                 // Patient Details Section
//                 pw.Padding(
//                     padding: pw.EdgeInsets.fromLTRB(40, 0, 40, 0),
//                 child: pw.Container(
//                   width: double.infinity,
//                   decoration: pw.BoxDecoration(
//                     border: pw.Border.all(color: PdfColors.black),
//                   ),
//                   padding: pw.EdgeInsets.all(10),
//                   child: pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       pw.Text("Patient Name :-  $patientName", style: pw.TextStyle(font: roboto, fontSize: 12)),
//                       pw.Text("Patient Age :-  $patientAge", style: pw.TextStyle(font: roboto, fontSize: 12)),
//                       pw.Text("Patient Gender :-  $patientGender", style: pw.TextStyle(font: roboto, fontSize: 12)),
//                       pw.Text("Patient Email :-  $patientEmail", style: pw.TextStyle(font: roboto, fontSize: 12)),
//                       pw.Text("Patient MobileNo. :-  $patientMobile", style: pw.TextStyle(font: roboto, fontSize: 12)),
//                     ],
//                   ),
//                 ),
//           ),
//
//                 pw.Text(riskLevel, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, font: roboto)),
//                 pw.Text(description, style: pw.TextStyle(fontSize: 12, font: roboto)),
//                 pw.Text(explanation , style: pw.TextStyle(fontSize: 12, font: roboto)),
//                 pw.Text(suggestion.join(", "), style: pw.TextStyle(fontSize: 12, font: roboto)),
//
//                 pw.SizedBox(height: 20),
//
//                 // Confidence Score Box
//                 pw.Container(
//                   padding: pw.EdgeInsets.all(10),
//                   decoration: pw.BoxDecoration(
//                     border: pw.Border.all(color: PdfColors.black),
//                   ),
//                   child: pw.Text(
//                     "Confidence Score for Skin Cancer ⇒  $confidenceScore",
//                     style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, font: roboto),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//
//     // Save the PDF file to temp directory
//     final output = await getTemporaryDirectory();
//     final file = File("${output.path}/${testType}_$patientName.pdf");
//     await file.writeAsBytes(await pdf.save());
//
//       CloudinaryService cloudinaryService = CloudinaryService();
//       String? url = await cloudinaryService.uploadPDF(file);
//
//     return url;
//   }
//
// }
// ...imports remain the same

// class PDFService {
//   Future<String?> generatePDF({
//     required String testType,
//     required File patientImageFile,
//     required File reportImageFile,
//     required String patientName,
//     required String patientAge,
//     required String patientGender,
//     required String patientEmail,
//     required String patientMobile,
//     required String confidenceScore,
//     required String riskLevel,
//     required String description,
//     required List<String> suggestion,
//     required String explanation,
//   }) async {
//     final pdf = pw.Document();
//
//     final typed_data.ByteData logoData = await flutter_services.rootBundle.load('assets/images/Logo.png');
//     final typed_data.Uint8List logoBytes = logoData.buffer.asUint8List();
//     final typed_data.Uint8List patientImage = await patientImageFile.readAsBytes();
//     final typed_data.Uint8List reportImage = await reportImageFile.readAsBytes();
//     final pw.Font roboto = pw.Font.ttf(await flutter_services.rootBundle.load("assets/fonts/Roboto-Regular.ttf"));
//
//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         margin: pw.EdgeInsets.all(16),
//         build: (pw.Context context) {
//           return pw.Container(
//             decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.black, width: 1)),
//             padding: pw.EdgeInsets.all(12),
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 // Logo
//                 pw.Center(child: pw.Image(pw.MemoryImage(logoBytes), height: 60)),
//
//                 pw.SizedBox(height: 12),
//
//                 // Report Title
//                 pw.Center(
//                   child: pw.Text(
//                     "$testType ASSESSMENT REPORT",
//                     style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, font: roboto),
//                   ),
//                 ),
//
//                 pw.SizedBox(height: 16),
//
//                 // Blue Patient Info Box
//                 pw.Container(
//                   width: double.infinity,
//                   color: PdfColor.fromHex("#dceefa"),
//                   padding: pw.EdgeInsets.all(10),
//                   child: pw.Row(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       // Patient Image
//                       pw.Container(
//                         height: 100,
//                         width: 80,
//                         decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.black)),
//                         child: pw.Image(pw.MemoryImage(patientImage), fit: pw.BoxFit.cover),
//                       ),
//                       pw.SizedBox(width: 16),
//                       // Patient Info
//                       pw.Expanded(
//                         child: pw.Column(
//                           crossAxisAlignment: pw.CrossAxisAlignment.start,
//                           children: [
//                             pw.Text("Patient Name : $patientName", style: pw.TextStyle(font: roboto, fontSize: 12)),
//                             pw.Text("Age : $patientAge", style: pw.TextStyle(font: roboto, fontSize: 12)),
//                             pw.Text("Gender : $patientGender", style: pw.TextStyle(font: roboto, fontSize: 12)),
//                             pw.Text("Patient Email Id : $patientEmail", style: pw.TextStyle(font: roboto, fontSize: 12)),
//                             pw.Text("Patient Contact No. : $patientMobile", style: pw.TextStyle(font: roboto, fontSize: 12)),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 pw.SizedBox(height: 16),
//
//                 // Medical Image + Confidence Score Box
//                 pw.Row(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     // Report Image
//                     pw.Column(
//                       children: [
//                         pw.Container(
//                           height: 120,
//                           width: 120,
//                           decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.black)),
//                           child: pw.Image(pw.MemoryImage(reportImage), fit: pw.BoxFit.cover),
//                         ),
//                         pw.SizedBox(height: 8),
//                         pw.Text("Medical Report Image", style: pw.TextStyle(fontSize: 10, font: roboto)),
//                       ],
//                     ),
//                     pw.SizedBox(width: 16),
//                     // Confidence Score Box
//                     pw.Expanded(
//                       child: pw.Container(
//                         padding: pw.EdgeInsets.all(10),
//                         color: PdfColor.fromHex("#dceefa"),
//                         child: pw.Column(
//                           crossAxisAlignment: pw.CrossAxisAlignment.start,
//                           children: [
//                             pw.Text("Confidence Score for Disease :  $confidenceScore",
//                                 style: pw.TextStyle(fontSize: 12, font: roboto)),
//                             pw.Text("Risk Level :  $riskLevel",
//                                 style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: roboto)),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 pw.SizedBox(height: 16),
//
//                 // Description
//                 pw.Text("Description :", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: roboto)),
//                 pw.SizedBox(height: 4),
//                 pw.Text(description, style: pw.TextStyle(fontSize: 11, font: roboto)),
//
//                 pw.SizedBox(height: 12),
//
//                 // Explanation
//                 pw.Text("Explanation :", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: roboto)),
//                 pw.SizedBox(height: 4),
//                 pw.Text(explanation, style: pw.TextStyle(fontSize: 11, font: roboto)),
//
//                 pw.SizedBox(height: 12),
//
//                 // Suggestion
//                 pw.Text("Suggestion :", style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: roboto)),
//                 pw.SizedBox(height: 4),
//                 pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: suggestion.map((sugg) {
//                     return pw.Padding(
//                       padding: pw.EdgeInsets.only(bottom: 4),
//                       child: pw.Bullet(
//                         text: sugg,
//                         style: pw.TextStyle(fontSize: 11, font: roboto),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//
//                 pw.SizedBox(height: 24),
//
//                 // Footer
//                 pw.Divider(),
//                 pw.Center(
//                   child: pw.Text(
//                     "Generated by InstaScan – AI Powered Diagnostic Tool\nAll predictions are AI-generated and must be clinically verified.",
//                     style: pw.TextStyle(fontSize: 9, font: roboto),
//                     textAlign: pw.TextAlign.center,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//
//     // Save the file
//     final output = await getTemporaryDirectory();
//     final file = File("${output.path}/${testType}_$patientName.pdf");
//     await file.writeAsBytes(await pdf.save());
//
//     CloudinaryService cloudinaryService = CloudinaryService();
//     String? url = await cloudinaryService.uploadPDF(file);
//     return url;
//   }
// }



class PDFService {
  Future<String?> generatePDF({
    required String testType,
    required File patientImageFile,
    required File reportImageFile,
    required String patientName,
    required String patientAge,
    required String patientGender,
    required String patientEmail,
    required String patientMobile,
    required String confidenceScore,
    required String riskLevel,
    required String description,
    required List<String> suggestion,
    required String explanation,
  }) async {
    final pdf = pw.Document();

    final typed_data.ByteData logoData = await flutter_services.rootBundle.load('assets/images/Logo2.png');
    final typed_data.Uint8List logoBytes = logoData.buffer.asUint8List();
    final typed_data.Uint8List patientImage = await patientImageFile.readAsBytes();
    final typed_data.Uint8List reportImage = await reportImageFile.readAsBytes();
    final pw.Font roboto = pw.Font.ttf(await flutter_services.rootBundle.load("assets/fonts/Roboto-Regular.ttf"));

    final String formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now());

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(16),
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.black, width: 1)),
            padding: pw.EdgeInsets.all(12),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Center(child: pw.Image(pw.MemoryImage(logoBytes), height: 90)),

                pw.SizedBox(height: 12),

                pw.Center(
                  child: pw.Text(
                    "$testType ASSESSMENT REPORT",
                    style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, font: roboto),
                  ),
                ),

                pw.SizedBox(height: 4),
                pw.Center(
                  child: pw.Text(
                    "Date: $formattedDate",
                    style: pw.TextStyle(fontSize: 10, font: roboto),
                  ),
                ),

                pw.SizedBox(height: 16),

                pw.Container(
                  width: double.infinity,
                  color: PdfColor.fromHex("#dceefa"),
                  padding: pw.EdgeInsets.all(10),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Container(
                        height: 100,
                        width: 80,
                        decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.black)),
                        child: pw.Image(pw.MemoryImage(patientImage), fit: pw.BoxFit.cover),
                      ),
                      pw.SizedBox(width: 16),
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("Patient Name : $patientName", style: pw.TextStyle(font: roboto, fontSize: 12)),
                            pw.Text("Age : $patientAge", style: pw.TextStyle(font: roboto, fontSize: 12)),
                            pw.Text("Gender : $patientGender", style: pw.TextStyle(font: roboto, fontSize: 12)),
                            pw.Text("Patient Email Id : $patientEmail", style: pw.TextStyle(font: roboto, fontSize: 12)),
                            pw.Text("Patient Contact No. : $patientMobile", style: pw.TextStyle(font: roboto, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 16),

                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Column(
                      children: [
                        pw.Container(
                          height: 120,
                          width: 120,
                          decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.black)),
                          child: pw.Image(pw.MemoryImage(reportImage), fit: pw.BoxFit.cover),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text("Medical Report Image", style: pw.TextStyle(fontSize: 10, font: roboto)),
                      ],
                    ),
                    pw.SizedBox(width: 16),
                    pw.Expanded(
                      child: pw.Container(
                        padding: pw.EdgeInsets.all(10),
                        color: PdfColor.fromHex("#dceefa"),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text("Confidence Score for Disease : $confidenceScore",
                                style: pw.TextStyle(fontSize: 12, font: roboto)),
                            pw.Text("Risk Level : $riskLevel",
                                style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, font: roboto)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                pw.SizedBox(height: 16),

                _sectionTitle("Description :", roboto),
                pw.Text(description, style: pw.TextStyle(fontSize: 10, font: roboto)),

                pw.SizedBox(height: 12),

                _sectionTitle("Explanation :", roboto),
                pw.Text(explanation, style: pw.TextStyle(fontSize: 10, font: roboto)),

                pw.SizedBox(height: 14),

                _sectionTitle("Suggestion :", roboto),
                pw.SizedBox(height: 4),
                pw.Container(padding: pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColor.fromHex("#dceefa")),color: PdfColor.fromHex("#dceefa")),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: suggestion.map((sugg) {
                      return pw.Bullet(text: sugg, style: pw.TextStyle(fontSize: 8, font: roboto));
                    }).toList(),
                  ),
                ),

                pw.SizedBox(height: 2),

                pw.Divider(),
                pw.Center(
                  child: pw.Text(
                    "Generated by InstaScan – AI Powered Diagnostic Tool\nAll predictions are AI-generated and must be clinically verified.",
                    style: pw.TextStyle(fontSize: 8, font: roboto),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.Align(
                  alignment: pw.Alignment.bottomRight,
                  child: pw.Text(
                    "Powered by InstaScan",
                    style: pw.TextStyle(fontSize: 4, font: roboto),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/${testType}_$patientName.pdf");
    await file.writeAsBytes(await pdf.save());

    CloudinaryService cloudinaryService = CloudinaryService();
    String? url = await cloudinaryService.uploadPDF(file);
    return url;
  }

  pw.Widget _sectionTitle(String title, pw.Font font) {
    return pw.Padding(
      padding: pw.EdgeInsets.only(bottom: 4),
      child: pw.Text(
        title,
        style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, decoration: pw.TextDecoration.underline, font: font),
      ),
    );
  }
}

