// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:eventifyQr/page/admin/admin_login.dart';
import 'package:flutter/material.dart';

class Admin_Splash_Screen_Page extends StatefulWidget {
  const Admin_Splash_Screen_Page({super.key});

  @override
  State<Admin_Splash_Screen_Page> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Admin_Splash_Screen_Page> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 120),
      () {
        // Navigate to the target widget
        Navigator.pushReplacementNamed(
          context,
          "/AdminLogin",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
        body: Text("Admin"),
      ),
    );
  }
}
