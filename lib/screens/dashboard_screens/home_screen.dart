import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7EC9D4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // Handle menu action
          },
        ),
        title: const Image(image: AssetImage('assets/images/Logo.png'))
      ),
      backgroundColor: const Color(0xFFFFFAFA),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Text
              const Text(
                "Welcome Back!\nJohn Doe",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Get your checkups",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              // Detection Cards
              _buildDetectionCard(
                context,
                title: 'Cancer Detection',
                subtitle: 'Skin cancer assessment using Skin lesion',
                icon: 'assets/images/skincancer.png',
                color: Colors.green,
              ),
              const SizedBox(height: 10),
              _buildDetectionCard(
                context,
                title: 'Pneumonia Detection',
                subtitle: 'Pneumonia assessment using Chest X-Ray',
                icon: 'assets/images/pneumonia.png',
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              // Healthy Tips Section
              const Text(
                "Healthy Tips & Tricks",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              _buildTipsList(),
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF7EC9D4),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }

  // Helper to build detection cards
  Widget _buildDetectionCard(BuildContext context,
      {required String title,
        required String subtitle,
        required String icon,
        required Color color}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF7EC9D4),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: color,
            child: Image.asset(
                icon,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper to build tips list
  Widget _buildTipsList() {
    final List<String> tips = [
      "Always keep your hands clean.",
      "Maintain a healthy diet.",
      "Exercise regularly.",
      "Get enough sleep daily.",
    ];

    return Column(
      children: tips
          .map(
            (tip) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Color(0xFFFFECEC),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.pink),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  tip,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          .toList(),
    );
  }
}
