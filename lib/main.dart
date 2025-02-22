import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instascan/firebase_options.dart';
import 'package:instascan/screens/onboarding_screens/onboarding_screen.dart';
import 'package:instascan/screens/splash_screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool('onboarding')??false;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(onboarding: onboarding,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.onboarding});
  final bool onboarding ;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(

      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: SplashScreen(),
        home: SplashScreen(onboarding: onboarding),
      ),
    );
  }
}

