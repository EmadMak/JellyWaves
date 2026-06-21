import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override 
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A1A1A),
      body: _buildSettingsScreen()
    );
  }

  Widget _buildSettingsScreen() {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 40, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Settings",
            style: TextStyle(
             color: Color(0xffDDC6A7), 
             fontSize: 30,
             fontWeight: FontWeight.bold,
            )
          )
        ],
      )
    );
  }
}
