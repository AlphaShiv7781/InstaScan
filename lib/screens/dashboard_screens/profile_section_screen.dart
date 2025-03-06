import 'package:flutter/material.dart';
import 'package:instascan/constants/userConsts.dart';

class ProfileSectionScreen extends StatefulWidget {
  const ProfileSectionScreen({super.key});

  @override
  State<ProfileSectionScreen> createState() => _ProfileSectionScreenState();
}

class _ProfileSectionScreenState extends State<ProfileSectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Profile Section'),
      ),
    );
  }
}
