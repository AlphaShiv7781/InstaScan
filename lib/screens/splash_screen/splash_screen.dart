import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instascan/screens/auth_screens/signin_screen.dart';
import 'package:instascan/screens/auth_screens/signup_screen.dart';
import 'package:instascan/screens/dashboard_screens/main_screen.dart';
import 'package:instascan/screens/onboarding_screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    Future.delayed(const Duration(seconds: 4), () {
      if(widget.onboarding==true){
        if(FirebaseAuth.instance.currentUser?.uid!=null)
        {
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
            precacheImage(AssetImage("assets/images/onboarding_assets/onboarding_1.webp"), context);
            precacheImage(AssetImage("assets/images/onboarding_assets/onboarding_2.webp"), context);
            precacheImage(AssetImage("assets/images/onboarding_assets/onboarding_3.webp"), context);
            precacheImage(AssetImage("assets/images/onboarding_assets/onboarding_4.webp"), context);
            precacheImage(AssetImage("assets/images/onboarding_assets/onboarding_5.webp"), context);
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
