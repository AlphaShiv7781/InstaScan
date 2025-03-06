import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instascan/constants/userConsts.dart';
import 'package:instascan/constants/validator.dart';
import 'package:instascan/custom_widgets/show_modal.dart';
import 'package:instascan/custom_widgets/text_formfield.dart';
import 'package:instascan/screens/auth_screens/signin_screen.dart';
import 'package:instascan/screens/dashboard_screens/main_screen.dart';
import 'package:instascan/services/auth_services/authentication_services.dart';
import 'package:instascan/services/auth_services/firestore_services.dart';
import 'package:instascan/services/database_services/database_services.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
  void initState() {
    // TODO: implement initState
    emailController= TextEditingController();
    passwordController= TextEditingController();
    nameController= TextEditingController();
    phoneNumberController= TextEditingController();
    super.initState();
  }

  AuthenticationServices authenticationServices= AuthenticationServices();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  late TextEditingController phoneNumberController;
  FirestoreServices firestoreServices=FirestoreServices();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,60,20,0),
          child: Form(
            key: formKey,
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
                TextformField('Enter Username', Icon(Icons.account_circle_outlined), false,nameValidator,TextInputType.name,nameController),
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
                TextformField('Enter Email address', Icon(Icons.email_outlined), false,emailValidator,TextInputType.emailAddress,emailController),
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
                TextformField('Enter Phone number', Icon(Icons.phone), false,mobileValidator,TextInputType.number,phoneNumberController),
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
                TextformField('Enter Password', Icon(Icons.password), true,passwordValidator,TextInputType.visiblePassword,passwordController),

                SizedBox(
                  height: 20,
                ),

                    Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Checkbox(
                // checkColor: Colors.black,
                // activeColor: Colors.white,
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

                //Sign-Up Button
                InkWell(
                  onTap: ()async{
                    if(formKey.currentState!.validate() && isChecked==true)
                      {
                        try{
                          ShowModal.showLoadingModal(context);
                          final newUser = await authenticationServices.signUp(emailController.text, passwordController.text);
                          if (newUser != null) {
                            await firestoreServices.saveUser(nameController.text , emailController.text , phoneNumberController.text , FirebaseAuth.instance.currentUser!.uid );
                          }

                          DataBaseRetrieval dbs =  DataBaseRetrieval();
                          String uid = FirebaseAuth.instance.currentUser!.uid;
                          userData = await dbs.getUserDataByUID(uid);

                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                        }
                        catch(e)
                        {
                          ShowModal.dismissLoadingModal(context);
                          showDialog(context: context, builder: (context)=>AlertDialog(
                            title: Text('Sign-Up Failed'),
                            content: Text('Sign-Up failed. Account already exists with this email.'),
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
                    else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.white,
                                content:
                                Text(
                                    'Accept Privacy policies & terms',
                                  style: TextStyle(
                                     color: Color(0xFF7EC9D4),
                                  ),
                                ),
                            ),
                        );
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
                  },
                  child: Text(
                    'Sign In',
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
