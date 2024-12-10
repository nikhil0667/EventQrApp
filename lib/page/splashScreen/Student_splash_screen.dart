// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eventifyQr/shared_Preference.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Student_Splash_Screen_Page extends StatefulWidget {
  const Student_Splash_Screen_Page({super.key});

  @override
  State<Student_Splash_Screen_Page> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Student_Splash_Screen_Page> {
  checkToken() async {
    var str = await GetPreference("student_token");

    Timer(
      const Duration(seconds: 3),
      () {
        // Determine the target widget using ternary operators
        String targetWidget = str == null ? '/StudentLogin' : '/StudentHome';

        // Navigate to the target widget
        Navigator.pushReplacementNamed(
          context,
          targetWidget,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Colors.teal.shade100, // You can change the background color
        body: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Event Management System',
                textStyle: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                speed: Duration(milliseconds: 200),
              ),
              FadeAnimatedText(
                'Welcome to Student!',
                textStyle: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black87,
                ),
              ),
            ],
            repeatForever: true, // Set to true for continuous animation
          ),
        ),
      ),
    );
  }
}
