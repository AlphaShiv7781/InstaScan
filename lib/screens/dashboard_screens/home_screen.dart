import 'package:flutter/material.dart';
import 'package:instascan/custom_widgets/dashboard_option_card.dart';
import 'package:instascan/custom_widgets/healthy_tipstrick_box.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              const Text(
                "Welcome Back!\nJohn Doe",
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


