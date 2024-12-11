import 'package:eventifyQr/page/admin/adminDeshbord.dart';
import 'package:eventifyQr/page/admin/admin_login.dart';
import 'package:eventifyQr/page/organizer/organizerHome.dart';
import 'package:eventifyQr/page/organizer/organizerLogin.dart';
import 'package:eventifyQr/page/organizer/organizerRegistrar.dart';
import 'package:eventifyQr/page/splashScreen/Admin_splash_screen.dart';
import 'package:eventifyQr/page/splashScreen/Organizer_splash_screen%20copy.dart';
import 'package:eventifyQr/page/splashScreen/Student_splash_screen.dart';
import 'package:eventifyQr/page/student/StudentHome.dart';
import 'package:eventifyQr/page/student/StudentLogin.dart';
import 'package:eventifyQr/page/student/StudentRegistration.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Event Mangement System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const Admin_Splash_Screen_Page(),
        // '/': (context) => const Student_Splash_Screen_Page(),
        // '/': (context) => const Organizer_Splash_Screen_Page(),
        // '/': (context) => EventCard(),
// ------------------------------------------------ Student Route ------------------------------------------------
        '/StudentHome': (context) => StudentHome(),
        '/StudentRegister': (context) => StudentRegistration(),
        '/StudentLogin': (context) => StudentLogin(),
// ------------------------------------------------ Admin Route ------------------------------------------------
        '/AdminLogin': (context) => AdminLoginPage(),

        '/AdminHome': (context) => const Admindeshbord(),
// ------------------------------------------------ Orgainzer Route ------------------------------------------------
        '/Organizerlogin': (context) => const OrganizerLogin(),
        '/OrganizerHome': (context) => OrganizerHome(),
        '/OrganizerRegistration': (context) => OrganizerRegistration(),
      },
    );
  }
}
