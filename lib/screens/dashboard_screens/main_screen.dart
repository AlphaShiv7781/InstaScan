import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instascan/screens/dashboard_screens/history_screen.dart';
import 'package:instascan/screens/dashboard_screens/home_screen.dart';
import 'package:instascan/screens/dashboard_screens/profile_section_screen.dart';
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
    HistoryScreen(userId: FirebaseAuth.instance.currentUser!.uid),
    ProfileSectionScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF7EC9D4),
        elevation: 0,
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
        type: BottomNavigationBarType.fixed,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Accounts',
          ),
        ],
      ),
    );
  }
}
