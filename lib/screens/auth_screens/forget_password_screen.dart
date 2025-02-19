import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instascan/constants/validator.dart';
import 'package:instascan/custom_widgets/text_formfield.dart';
import 'package:instascan/screens/auth_screens/signin_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  TextEditingController _emailController= TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _emailController= TextEditingController();
    super.initState();
  }

  Future<void> forgetPassword() async {

    try{

      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text('Success'),
          content: Text('A link is shared on your email to reset password and login again'),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      } );
    } on FirebaseAuthException catch(e){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text('Error'),
          content: Text(e.message.toString()),
          actions: [
            TextButton(
                onPressed: (){
                   Navigator.pop(context);
                },
                child: Text('OK'),
            ),
          ],
        );
      } );
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0 , 0 , 20 , 0),
        child: Column(

          children: [
                 Image(image: AssetImage('assets/images/Logo.png'),),

                 SizedBox(
                   height: 80,
                 ),

                 Text(
                     'Enter E-mail Address to reset password',
                     style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                     ),
                 ),
                  SizedBox(
                    height: 20,
                  ),
                  TextformField(
                      'Enter E-mail',
                      Icon(Icons.email),
                      false,
                      emailValidator,
                      TextInputType.emailAddress,
                      _emailController,
                  ),

                  SizedBox(
                    height: 50,
                  ),

                  ElevatedButton(
                      onPressed: () async{
                           await forgetPassword();

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                          textStyle: TextStyle(
                            fontSize: 20,

                          ),
                        ),
                        child: Text(
                            'Change Password',
                             style: TextStyle(
                               color: Colors.white,
                             ),
                        ),
                  ),

          ],
        ),
      ),

    );
  }
}
