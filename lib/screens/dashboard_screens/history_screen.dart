import 'package:flutter/material.dart';
import 'package:instascan/custom_widgets/dashboard_option_card.dart';
import 'package:instascan/custom_widgets/healthy_tipstrick_box.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color
      body: Center(
        child: Text('History of Assessments'),
      ),
    );
  }
}
