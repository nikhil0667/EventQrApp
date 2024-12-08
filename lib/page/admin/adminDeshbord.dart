import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Admindeshbord extends StatefulWidget {
  const Admindeshbord({super.key});

  @override
  State<Admindeshbord> createState() => _AdmindeshbordState();
}

class _AdmindeshbordState extends State<Admindeshbord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("ADMIN DESHBORD")),
    );
  }
}
