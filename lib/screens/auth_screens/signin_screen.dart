import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:instascan/custom_widgets/text_formfield.dart';
import 'package:instascan/screens/auth_screens/signup_screen.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7EC9D4),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20 ,0 , 20 , 0),
        child: SingleChildScrollView(
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
              TextformField('Email Address', Icon(Icons.email_outlined) , false),
          
              SizedBox(
                height: 30,
              ),
          
              //Password TextField
              TextformField('Password', Icon(Icons.lock_outline) , true),
          
              SizedBox(
                height: 30,
              ),
          
              //Sign-In Button
              InkWell(
                onTap: (){

                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF023A1D),
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
                  child: Text(
                      'Forgot Password?',
                    style: TextStyle(
                      fontWeight: FontWeight.w700
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
                        color: Color(0xFF023A1D),
                        fontWeight: FontWeight.w700
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
