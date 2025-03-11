import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instascan/constants/validator.dart';
import 'package:instascan/custom_widgets/show_modal.dart';
import 'package:instascan/custom_widgets/text_formfield.dart';
import 'package:instascan/screens/result_screen/result_screen.dart';
import 'package:instascan/services/api_services/pneumonia_api_service.dart';
import 'package:intl/intl.dart';
class PneumoniaAssessmentFormScreen extends StatefulWidget {
  const PneumoniaAssessmentFormScreen({super.key});

  @override
  State<PneumoniaAssessmentFormScreen> createState() => _PneumoniaAssessmentFormScreenState();
}

class _PneumoniaAssessmentFormScreenState extends State<PneumoniaAssessmentFormScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _gender;
  File? _patientImage;
  File? _chestXrayImage;
  final ImagePicker _picker = ImagePicker();


  Future<void> _pickImage(ImageSource source, bool isPatient) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (isPatient) {
          _patientImage = File(pickedFile.path);
        } else {
          _chestXrayImage = File(pickedFile.path);
        }
      });
    }
  }


  //DOB function
  final TextEditingController _dobController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Patient Form",
          style: TextStyle(
              fontFamily: 'Aldrich'
          ),
        ),
        backgroundColor: Color(0xFF7EC9D4),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20,30,20,0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [

                Text('Pneumonia Assessment' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w900,fontFamily: 'Aldrich'),),

                SizedBox(
                  height: 20,
                ),

                //Image Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    //Patient Image
                    Column(
                      children: [
                        Text("Patient Image", style: TextStyle(fontWeight: FontWeight.bold)),
                        _patientImage != null
                            ? Image.file(_patientImage!, height: 100, width: 100)
                            : Icon(Icons.image, size: 100),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF7EC9D4),
                          ),
                          onPressed: () => _pickImage(ImageSource.gallery, true),
                          child: Text("Pick Patient Image",style: TextStyle(color: Colors.white),),
                        ),

                      ],
                    ),

                    SizedBox(height: 10),

                    //Lesion Image
                    Column(
                      children: [
                        Text("ChestXray Image", style: TextStyle(fontWeight: FontWeight.bold)),
                        _chestXrayImage != null
                            ? Image.file(_chestXrayImage!, height: 100, width: 100)
                            : Icon(Icons.image, size: 100),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF7EC9D4),
                          ),
                          onPressed: () => _pickImage(ImageSource.gallery, false),
                          child: Text("Pick Lesion Image",style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),

                //name
                TextformField('Patient Name', Icon(Icons.person) , false, nameValidator,TextInputType.name ,_nameController),

                SizedBox(
                  height: 15,
                ),

                //email
                TextformField('Email Address', Icon(Icons.email_outlined) , false, emailValidator ,TextInputType.emailAddress ,_emailController ),

                SizedBox(
                  height: 15,
                ),

                //contact no.
                TextformField('Phone Number', Icon(Icons.phone) , false, emailValidator ,TextInputType.phone ,_phoneController ),

                SizedBox(
                  height: 15,
                ),

                //age
                TextformField('Age', Icon(Icons.account_circle) , false, emailValidator ,TextInputType.emailAddress ,_ageController ),
                SizedBox(
                  height: 15,
                ),

                //Date of Birth
                TextField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'Date of Birth',
                    suffixIcon: Icon(Icons.calendar_today),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  onTap: () => _selectDate(context),
                ),

                SizedBox(
                  height: 15,
                ),

                //Gender
                DropdownButtonFormField<String>(
                  value: _gender,
                  items: ["Male", "Female", "Other"].map((String category) {
                    return DropdownMenuItem(value: category, child: Text(category));
                  }).toList(),
                  onChanged: (value) => setState(() => _gender = value),
                  decoration: InputDecoration(
                    hintText: 'Gender',
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  validator: (value) => value == null ? "Select Gender" : null,
                ),

                SizedBox(
                  height: 40,
                ),

                //Submit Button
                InkWell(
                  onTap: ()async{
                    try{

                      if (_formKey.currentState!.validate() && _patientImage != null && _chestXrayImage != null) {
                        // Process form data & send to Firebase TFLite model
                        ShowModal.showLoadingModal(context);
                        print(await PneumoniaApiService.pneumoniaApi(_chestXrayImage!));
                        String prediction = await PneumoniaApiService.pneumoniaApi(_chestXrayImage!)?? 'Unknown';
                        print(prediction);
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => ResultScreen(
                            result: prediction,
                            patientImage: _patientImage,
                            skinLesionImage: _chestXrayImage,
                            name: _nameController.text,
                            phoneNumber: _phoneController.text,
                            email: _emailController.text,
                            age: _ageController.text,
                            dob: _dobController.text,
                            gender: _gender!, testType: 'PNEUMONIA',
                          ),),
                              (route) => false, // Removes all previous routes
                        );
                        print("Submitting Form...");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please fill all fields and select images")),
                        );
                      }

                    }
                    catch (e){
                      ShowModal.dismissLoadingModal(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF7EC9D4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Aldrich'
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
