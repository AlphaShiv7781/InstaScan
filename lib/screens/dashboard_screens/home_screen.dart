import 'package:flutter/material.dart';
import 'package:instascan/constants/userConsts.dart';
import 'package:instascan/custom_widgets/dashboard_option_card.dart';
import 'package:instascan/custom_widgets/healthy_tipstrick_box.dart';
import 'package:instascan/screens/pneumonia_screen/pneumonia_screen.dart';
import 'package:instascan/screens/skin_cancer_screens/skin_cancer_assessmentform.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Text(
                     "Welcome Back!\n${userData?['name']??null}",
                     style: TextStyle(
                       fontSize: 24,
                       fontWeight: FontWeight.bold,
                       color: Colors.black, // Explicit text color
                     ),
                   ),
                    const Spacer(),
                   Material(
                     shape: CircleBorder(),
                      shadowColor: Colors.blueGrey,
                      elevation: 8,
                     child: Container(
                       padding: EdgeInsets.all(4), // Thickness of the border
                       decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         border: Border.all(color: Colors.cyan, width: 4), // Outer ring
                       ),

                       child: CircleAvatar(
                         radius: 50,
                         backgroundColor: Colors.grey[300],
                         backgroundImage: userData?['profileUrl'] != null ? NetworkImage(userData?['profileUrl']) : null,
                         child: userData?['profileUrl'] == null
                             ? Text(
                           userData?['name'][0],
                           style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                         )
                             : null,
                       ),
                     ),
                   ),
                 ],
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
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> PneumoniaAssessmentFormScreen()));
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,10.0),
                child: const HealthyTipsTrickBox(),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}


