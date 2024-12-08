// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:eventifyQr/page/admin/admin_login.dart';
import 'package:eventifyQr/shared_Preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Organizer_Splash_Screen_Page extends StatefulWidget {
  const Organizer_Splash_Screen_Page({super.key});

  @override
  State<Organizer_Splash_Screen_Page> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Organizer_Splash_Screen_Page> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 120),
      () {
        // Navigate to the target widget
        Navigator.pushNamed(
          context,
          "/Organizerlogin",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
        body: Text("Organizer"),
      ),
    );
  }
}
