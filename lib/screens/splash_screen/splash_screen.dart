import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instascan/constants/userConsts.dart';
import 'package:instascan/screens/auth_screens/signup_screen.dart';
import 'package:instascan/screens/dashboard_screens/main_screen.dart';
import 'package:instascan/screens/onboarding_screens/onboarding_screen.dart';
import 'package:instascan/services/database_services/database_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onboarding});

  final bool onboarding;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState () {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 4), () async{
      if(widget.onboarding==true){
        if(FirebaseAuth.instance.currentUser?.uid!=null)
        {
          DataBaseRetrieval dbs =  DataBaseRetrieval();
          String uid = FirebaseAuth.instance.currentUser!.uid;

            userData = await dbs.getUserDataByUID(uid);

          print(userData);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        }
        else
        {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()),
          );
        }
      }
      else
        {

          WidgetsBinding.instance.addPostFrameCallback((_) {
            precacheImage(AssetImage("assets/images/onboarding_assets/Lightonboarding_1.webp"), context);
            precacheImage(AssetImage("assets/images/onboarding_assets/Lightonboarding_2.webp"), context);
            precacheImage(AssetImage("assets/images/onboarding_assets/Lightonboarding_3.webp"), context);
            precacheImage(AssetImage("assets/images/onboarding_assets/Lightonboarding_4.webp"), context);
            precacheImage(AssetImage("assets/images/onboarding_assets/Lightonboarding_5.webp"), context);
          });

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const OnboardingScreen()));
        }
    });

    super.initState();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7EC9D4),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ZoomIn(
              duration: Duration(seconds: 2),
              child: Image(
                image: AssetImage('assets/images/Logo.png'),
              ),
          ),
        ],
      ),
    );
  }
}
