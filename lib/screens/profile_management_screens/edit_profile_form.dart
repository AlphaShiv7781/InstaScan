import 'package:flutter/material.dart';
import 'package:instascan/constants/validator.dart';
import 'package:instascan/custom_widgets/text_formfield.dart';
class ProfileEditingForm extends StatefulWidget {
  const ProfileEditingForm({super.key});

  @override
  State<ProfileEditingForm> createState() => _ProfileEditingFormState();
}

class _ProfileEditingFormState extends State<ProfileEditingForm> {

  TextEditingController nameController = TextEditingController();
  TextEditingController alternateEmailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xFF7EC9D4),
        actions: [
          IconButton(
            onPressed: () {
              // Save the data to the database
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0,90,20,0),
        child: Column(
          children: [
            TextformField('Name', Icon(Icons.account_circle_outlined) , false, nameValidator,TextInputType.name ,nameController ),
            const SizedBox(height: 20,),
            TextformField('Alternate Email Address', Icon(Icons.email_outlined) , false, emailValidator ,TextInputType.emailAddress ,alternateEmailController ),
            const SizedBox(height: 20,),
            TextformField('Phone Number', Icon(Icons.phone) , false, mobileValidator ,TextInputType.phone ,phoneController ),
            const SizedBox(height: 20,),
            TextformField('Residential Address', Icon(Icons.add_home) , false, null ,TextInputType.streetAddress ,addressController ),
            const SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}
