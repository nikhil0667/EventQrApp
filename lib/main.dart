import 'package:eventifyQr/page/admin/adminDeshbord.dart';
import 'package:eventifyQr/page/admin/admin_login.dart';
import 'package:eventifyQr/page/organizer/organizerHome.dart';
import 'package:eventifyQr/page/organizer/organizerLogin.dart';
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
      title: 'Deepvecto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: {
        //'/': (context) => const Admin_Splash_Screen_Page(),
        //'/': (context) => const Student_Splash_Screen_Page(),
        //'/': (context) => const Organizer_Splash_Screen_Page(),
        //'/': (context) =>  createEvent(),
// ------------------------------------------------ Student Route ------------------------------------------------
        '/StudentHome': (context) => StudentHome(),
        '/StudentRegister': (context) => StudentRegistration(),
        '/StudentLogin': (context) => StudentLogin(),
// ------------------------------------------------ Admin Route ------------------------------------------------
        '/AdminLogin': (context) => AdminLoginPage(),
        '/AdminHome': (context) => Admindeshbord(),
// ------------------------------------------------ Orgainzer Route ------------------------------------------------
        '/Organizerlogin': (context) => const OrganizerLogin(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
