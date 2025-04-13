import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instascan/constants/validator.dart';
import 'package:instascan/custom_widgets/text_formfield.dart';


class UserInputBottomSheet extends StatefulWidget {
  const UserInputBottomSheet({Key? key}) : super(key: key);

  @override
  State<UserInputBottomSheet> createState() => _UserInputBottomSheetState();
}

class _UserInputBottomSheetState extends State<UserInputBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _alternateEmailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      await FirebaseFirestore.instance.collection('users').add({
        'name': _nameController.text.trim(),
        'email': _alternateEmailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      Navigator.of(context).pop(); // Close the bottom sheet
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _alternateEmailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 40,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextformField('Enter Name', Icon(Icons.account_circle_outlined), false, nameValidator, TextInputType.name, _nameController),
            SizedBox(height: 20),
            TextformField('Enter Mobile Number', Icon(Icons.phone), false, mobileValidator, TextInputType.number, _phoneController),
            SizedBox(height: 20),
            TextformField('Enter Alternate Email', Icon(Icons.email), false, emailValidator, TextInputType.emailAddress, _alternateEmailController),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              // onPressed: _isSubmitting ? null : _submitData,
              onPressed: (){},
              child: _isSubmitting
                  ? const CircularProgressIndicator()
                  : const Text('Submit' ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold , fontSize: 16),),
            ),
          ],
        ),
      ),
    );
  }
}
