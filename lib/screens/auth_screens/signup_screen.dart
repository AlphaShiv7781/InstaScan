import 'package:flutter/material.dart';
import 'package:instascan/custom_widgets/text_formfield.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7EC9D4),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,60,20,0),
          child: Column(
            children: [
               Center(
                 child: Text(
                     'Create Account',
                   style: TextStyle(
                     fontWeight: FontWeight.w700,
                     fontSize: 28,
                   ),
                 ),
               ),
              SizedBox(
                height: 60,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                    'Username',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextformField('Enter Username', Icon(Icons.account_circle_outlined), false),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'E-mail',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextformField('Enter Email address', Icon(Icons.email_outlined), false),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Phone Number',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextformField('Enter Phone number', Icon(Icons.phone), false),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Password',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextformField('Enter Password', Icon(Icons.password), true),

              SizedBox(
                height: 20,
              ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Checkbox(
              checkColor: Colors.black,
              activeColor: Colors.white,
              hoverColor: Colors.white,
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value ?? false; // Update the checkbox value
                });
              },
            ),
            Text(
                'Agree to terms & conditions and privacy policy',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700
              ),
            ),
          ],
        ),

              SizedBox(
                height: 10,
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
                      'Sign Up',
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
                height: 80,
              ),
              Text(
                "Already have an account?",
                style: TextStyle(
                    fontWeight: FontWeight.w600
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text(
                  'Sign In',
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
