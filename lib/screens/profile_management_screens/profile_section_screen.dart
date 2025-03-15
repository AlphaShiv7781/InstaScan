import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instascan/constants/userConsts.dart';
import 'package:instascan/screens/auth_screens/signin_screen.dart';
import 'package:instascan/screens/dashboard_screens/history_screen.dart';
import 'package:instascan/screens/profile_management_screens/edit_profile_form.dart';

class ProfileSectionScreen extends StatefulWidget {
  const ProfileSectionScreen({super.key});

  @override
  State<ProfileSectionScreen> createState() => _ProfileSectionScreenState();
}

class _ProfileSectionScreenState extends State<ProfileSectionScreen> {

  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    // Compress Image
    final compressedImage = await _compressImage(File(pickedFile.path));

    setState(() {
      _image = compressedImage ;
    });

    await uploadImageToCloudinary();
  }

  Future<File> _compressImage(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf('.');
    final newPath = '${filePath.substring(0, lastIndex)}_compressed.jpg';

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, newPath,
      quality: 70, // Reduce quality to 70%
    );

    return File(compressedFile!.path); // Explicitly return File
  }


  Future<void> uploadImageToCloudinary() async {
    if (_image == null) {
      print("No image selected");
      return;
    }

    try {
      final url = Uri.parse("https://api.cloudinary.com/v1_1/${dotenv.env['cloudName']}/image/upload");
      String uploadPreset = dotenv.env['uploadPreset']!;

      var request = http.MultipartRequest("POST", url)
        ..fields['upload_preset'] = uploadPreset
        ..fields['resource_type'] = 'image' // Explicitly setting resource type
        ..files.add(await http.MultipartFile.fromPath("file", _image!.path));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print("Cloudinary Response: $responseBody");  // Debugging log

      if (response.statusCode == 200) {
        var responseData = jsonDecode(responseBody);
        String imageUrl = responseData['secure_url'];

        // Update Firestore
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).update({
          'profileUrl': imageUrl,
        });

        setState(() {
          userData?['profileUrl'] = imageUrl;
        });

        print("Image uploaded successfully: $imageUrl");
      } else {
        print("Failed to upload image: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Cloudinary Upload Error: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocumentCount();
  }

  int count=0;

  Future<void> getDocumentCount() async {
    AggregateQuerySnapshot countSnapshot =
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('history').count().get();
    setState(() {
      count = countSnapshot.count!;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0,80,0,0),
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      Material(
                        shape: CircleBorder(),
                        elevation: 8,
                        child: Container(
                          padding: EdgeInsets.all(4), // Thickness of the border
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.cyan, width: 4), // Outer ring
                          ),

                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: userData?['profileUrl'] != null ? NetworkImage(userData?['profileUrl']!) : null,
                            child: userData?['profileUrl'] == null
                                ? Text(
                              "${userData?['name']?[0]}",
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            )
                                : null,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 110,
                        left:110 ,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color:Colors.black54, width: 3),
                          ),
                          padding: EdgeInsets.all(2),
                          child: Icon(Icons.edit, size: 25, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "${userData?['name']}",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Aldrich'
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "${userData?['email']}",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Aldrich'
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEditingForm()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.cyan),
                ),
                child: Text(
                    "Edit Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Aldrich'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0,30,30.0,0),
                child: Divider(),
              ),
              Container(
                margin: EdgeInsets.all(30),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                        'No. of Tests Taken : ',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          fontFamily: 'Dongle'
                        ),
                    ),
                    Text(
                         '$count',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        fontFamily: 'Dongle'
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryScreen(userId: FirebaseAuth.instance.currentUser!.uid,)));
                },
                style:ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // Change border radius here
                  ),
                ),
                child: Text(
                  "View History",
                  style: TextStyle(
                      color: Colors.white,
                    fontFamily: 'Aldrich'
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(30.0,30,30,0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: (){
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
                      },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // Change border radius here
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                    ),
                      child: Text(
                          "Logout",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Aldrich',fontWeight: FontWeight.w700
                        ),
                      ),
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
