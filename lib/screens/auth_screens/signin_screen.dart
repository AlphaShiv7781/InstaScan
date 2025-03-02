import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:instascan/constants/validator.dart';
import 'package:instascan/custom_widgets/show_modal.dart';
import 'package:instascan/custom_widgets/text_formfield.dart';
import 'package:instascan/screens/auth_screens/forget_password_screen.dart';
import 'package:instascan/screens/auth_screens/signup_screen.dart';
import 'package:instascan/screens/dashboard_screens/main_screen.dart';
import 'package:instascan/services/auth_services/authentication_services.dart';
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
      backgroundColor: Colors.white,
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
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ],
                ),
            
                Text(
                    'Please sign in to continue ',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),
                ),
            
                SizedBox(
                  height: 80,
                ),
            
                //E-mail TextField
                TextformField('Email Address', Icon(Icons.email_outlined) , false, emailValidator ,TextInputType.emailAddress ,emailController ),
            
                SizedBox(
                  height: 30,
                ),
            
                //Password TextField
                TextformField('Password', Icon(Icons.lock_outline) , true , passwordValidator , TextInputType.visiblePassword , passwordController),
            
                SizedBox(
                  height: 30,
                ),
            
                //Sign-In Button
                InkWell(
                  onTap: ()async{
                   if(formKey.currentState!.validate())
                     {
                       try {
                         // Show loading modal while the sign-in process is running
                          ShowModal.showLoadingModal(context);
                          await signInTask();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
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
                          fontWeight: FontWeight.w500
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
                         color:  Color(0xFF7EC9D4)
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
                      fontWeight: FontWeight.w600
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
                          fontWeight: FontWeight.w700
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
