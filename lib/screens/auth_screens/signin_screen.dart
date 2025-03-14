import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instascan/constants/validator.dart';
import 'package:instascan/custom_widgets/show_modal.dart';
import 'package:instascan/custom_widgets/text_formfield.dart';
import 'package:instascan/screens/auth_screens/forget_password_screen.dart';
import 'package:instascan/screens/auth_screens/signup_screen.dart';
import 'package:instascan/screens/dashboard_screens/main_screen.dart';
import 'package:instascan/services/auth_services/authentication_services.dart';
import 'package:instascan/services/database_services/database_services.dart';
import 'package:instascan/constants/userConsts.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  AuthenticationServices authenticationServices= AuthenticationServices();


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signInTask() async {

    final user = await authenticationServices.signIn(emailController.text, passwordController.text);
    if (user == null) {
      throw Exception('Sign-in failed. Please check your credentials.');
    }
  }



  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.cyan.shade50,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20 ,0 , 20 , 0),
        child: SingleChildScrollView(
          child: Form(
            key:formKey,
            child: Column(
              children: [
                Image(image: AssetImage('assets/images/Logo.png')),
                AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                          'Welcome Back!',
                        textStyle: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          fontFamily: 'Aldrich'
                        ),
                      ),
                    ],
                ),

                Text(
                    'Please sign in to continue ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Aldrich'
                  ),
                ),

                SizedBox(
                  height: 80,
                ),

                //E-mail TextField

                TextformField('Email Address', Icon(Icons.email_outlined ,color: Colors.grey,) , false, emailValidator ,TextInputType.emailAddress ,emailController ),



                SizedBox(
                  height: 30,
                ),

                //Password TextField

                TextformField('Password', Icon(Icons.lock_outline,color: Colors.grey,) , true , passwordValidator , TextInputType.visiblePassword , passwordController),



                SizedBox(
                  height: 30,
                ),

                //Sign-In Button
                InkWell(

                  borderRadius: BorderRadius.circular(10),

                  onTap: ()async{
                   if(formKey.currentState!.validate())
                     {
                       try {
                         // Show loading modal while the sign-in process is running
                          ShowModal showLoadingModal = ShowModal(title: 'Signing in...');
                          showLoadingModal.showLoadingModal(context);
                          await signInTask();
                          DataBaseRetrieval dbs =  DataBaseRetrieval();
                          String uid = FirebaseAuth.instance.currentUser!.uid;
                          userData = await dbs.getUserDataByUID(uid);

                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainScreen()),(route)=>false);
                       } catch (e) {
                         // Handle error: display SnackBar
                         ShowModal.dismissLoadingModal(context);
                         showDialog(context: context, builder: (context)=>AlertDialog(
                           title: Text('Sign-In Failed'),
                           content: Text('Sign-in failed. Please check your credentials.'),
                           actions: [
                             TextButton(

                               onPressed: (){
                                 Navigator.pop(context);
                               },
                               child: Text(
                                   'OK',
                                 style: TextStyle(
                                   color: Color(0xFF7EC9D4),
                                 ),
                               ),
                             ),
                           ],
                         ));
                       }
                     }
                  },
                  child: Material(
                    elevation: 5,
                    shadowColor: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF7EC9D4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Center(
                        child: Text(
                          'Sign In',
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
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(220,0,0,0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordScreen()));
                    },
                    child: Text(
                        'Forgot Password?',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                         color:  Color(0xFF7EC9D4),
                          fontFamily: 'Aldrich',
                        fontSize: 12
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Aldrich',
                    fontSize: 12
                  ),
                ),
                TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                    },
                    child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF7EC9D4),
                          fontWeight: FontWeight.w700,
                            fontFamily: 'Aldrich',
                          fontSize: 12
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
