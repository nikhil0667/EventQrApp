// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:eventifyQr/page/student/StudentLogin.dart';
import 'package:eventifyQr/shared_Preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Student_Splash_Screen_Page extends StatefulWidget {
  const Student_Splash_Screen_Page({super.key});

  @override
  State<Student_Splash_Screen_Page> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Student_Splash_Screen_Page> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 120),
      () {
        // Navigate to the target widget
        Navigator.pushReplacementNamed(
          context,
          "/StudentLogin",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
        body: Text("Student"),
      ),
    );
  }
}
