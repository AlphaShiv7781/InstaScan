import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instascan/custom_widgets/show_modal.dart';
import 'package:instascan/screens/dashboard_screens/main_screen.dart';
import 'package:instascan/screens/result_screen/components/patient_detail_component.dart';
import 'package:instascan/screens/result_screen/components/result_image_widget.dart';
import 'package:instascan/services/auth_services/firestore_services.dart';
import 'package:instascan/services/pdf_services/pdf_generator.dart';
import 'package:instascan/services/pdf_services/pdf_retrieval.dart';

class SkinCancerResultScreen extends StatefulWidget {
   const SkinCancerResultScreen({super.key, required this.result, required this.patientImage, required this.skinLesionImage, required this.name, required this.phoneNumber, required this.email, required this.age, required this.dob, required this.gender});
   final String result;
   final File? patientImage;
   final File? skinLesionImage;
   final String name;
   final String phoneNumber;
   final String email;
   final String age;
   final String dob;
   final String gender;

  @override
  State<SkinCancerResultScreen> createState() => _SkinCancerResultScreenState();
}

class _SkinCancerResultScreenState extends State<SkinCancerResultScreen> {

  PDFService pdfService = new PDFService();
  FirestoreServices firestoreServices=new FirestoreServices();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20,40,20,0),
        child: SingleChildScrollView(
          child: Column(
          
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Image.asset('assets/images/Logo2.png', height: 50, width: 200,),
              ),
          
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ResultImageWidget(imageFile:widget.patientImage,imageType: 'Patient Image'),
                    SizedBox(
                      width: 10,
                    ),
                    ResultImageWidget(imageFile:widget.skinLesionImage,imageType: 'Lesion Image'),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black54,
                    width: 2,
                  ),
                ),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: PatientDetailComponent(name: widget.name, phoneNumber: widget.phoneNumber, email: widget.email, age: widget.age, dob: widget.dob, gender: widget.gender,),
              ),
              SizedBox(
                height: 70,
              ),
              Center(
                  child: Text(
                      'Confidence Score for Disease :->${widget.result}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                    ),
                  ),
              ),
              SizedBox(
                height: 80,
              ),
              FloatingActionButton.extended(
                backgroundColor: Colors.cyan,
                heroTag: null,
                onPressed: ()async{
                  ShowModal.showLoadingModal(context);
                  String? url = await pdfService.generatePDF(

                      patientName: widget.name,
                      patientAge: widget.age,
                      patientGender: widget.gender,
                      patientEmail: widget.email,
                      patientMobile: widget.phoneNumber,
                      confidenceScore: widget.result,
                      patientImageFile: widget.patientImage!,
                      reportImageFile: widget.skinLesionImage!
                  );

                  if (url == null) {
                    print("PDF generation or upload failed.");
                    return;
                  }

                  String userId = FirebaseAuth.instance.currentUser!.uid;
                  await firestoreServices.savePDFUrl(userId, url);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
                },
                label: Text(
                  'Go Back to Home',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                  ),
                ),

              ),
              SizedBox(
                height: 15,
              ),
              FloatingActionButton.extended(
                backgroundColor: Colors.redAccent,
                onPressed: () async{
                  ShowModal.showLoadingModal(context);
                  String? url = await pdfService.generatePDF(

                      patientName: widget.name,
                      patientAge: widget.age,
                      patientGender: widget.gender,
                      patientEmail: widget.email,
                      patientMobile: widget.phoneNumber,
                      confidenceScore: widget.result,
                      patientImageFile: widget.patientImage!,
                      reportImageFile: widget.skinLesionImage!
                  );

                  if (url == null) {
                    print("PDF generation or upload failed.");
                    return;
                  }
                  String userId = FirebaseAuth.instance.currentUser!.uid;
                  await firestoreServices.savePDFUrl(userId, url);
                  openPDF(url);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
                },
                heroTag: null,
                label: Text(
                  'Download Report as PDF',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                  ),
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
