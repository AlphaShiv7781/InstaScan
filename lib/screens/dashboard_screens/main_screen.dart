import 'package:flutter/material.dart';
import 'package:instascan/screens/dashboard_screens/home_screen.dart';
import 'news_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selected = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const NewsScreen(),
    const Center(child: Text("History Screen")), // Placeholder for History
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7EC9D4),
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/images/User.png'),
          onPressed: () {
            // Handle menu action
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset('assets/images/Logo2.png'),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFFFFAFA),
      body: screens[_selected],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF7EC9D4),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        currentIndex: _selected,
        onTap: (index) {
          setState(() {
            _selected = index;
          });
        },
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
}
