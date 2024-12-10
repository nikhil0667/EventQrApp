// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
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
  checkToken() async {
    var str = await GetPreference("organizer_token");

    Timer(
      const Duration(seconds: 3),
      () {
        // Determine the target widget using ternary operators
        String targetWidget =
            str == null ? '/Organizerlogin' : '/OrganizerHome';

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
        backgroundColor: Colors.blue, // You can change the background color
        body: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Event Management System',
                textStyle: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                speed: Duration(milliseconds: 200),
              ),
              FadeAnimatedText(
                'Welcome to Organizer!',
                textStyle: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
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
