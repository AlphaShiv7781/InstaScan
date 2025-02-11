import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instascan/custom_widgets/dashboard_option_card.dart';
import 'package:instascan/custom_widgets/healthy_tipstrick_box.dart';
import 'package:instascan/screens/skin_cancer_screens/skin_cancer_assessmentform.dart';
import 'package:instascan/services/database_services/database_services.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    fetchUserData();
    super.initState();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, dynamic>? userData;
  String _name='';

  DataBaseRetrieval dbs =  DataBaseRetrieval();

  Future<void> fetchUserData() async {
    User? user = auth.currentUser;

    if (user != null) {
      String uid = user.uid;
      userData = await dbs.getUserDataByUID(uid);
      print(userData);
      if (userData != null) {
        setState(() {
          _name=userData?['name'];
        });
      } else {
        setState(() {
          _name="Unknown";
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                "Welcome Back!\n$_name",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Explicit text color
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                "Get your checkups",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>SkinCancerAssessmentFormScreen()));
                },
                splashColor: Colors.cyan,

                child: DashBoardOptionCard(
                  title: 'Cancer Detection',
                  subtitle: 'Skin cancer assessment using Skin lesion',
                  icon: 'assets/images/skincancer.png',
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: (){

                },
                splashColor: Colors.cyan,
                child: DashBoardOptionCard(
                  title: 'Pneumonia Detection',
                  subtitle: 'Pneumonia assessment using Chest X-Ray',
                  icon: 'assets/images/pneumonia.png',
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Healthy Tips & Tricks",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const HealthyTipsTrickBox(),
            ],
          ),
        ),
      ),
    );
  }
}


