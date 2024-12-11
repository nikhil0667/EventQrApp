import 'package:eventifyQr/page/EventView.dart';
import 'package:eventifyQr/page/createEvent.dart';
import 'package:eventifyQr/shared_Preference.dart';
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
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange, // Changed color
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://ui-avatars.com/api/?name=John+Doe'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'john.doe@example.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Drawer Items
            ListTile(
              leading: Icon(Icons.home, color: Colors.deepOrange),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.event, color: Colors.deepOrange),
              title: Text("Create Event"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateEventPage(type: "create")),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.event, color: Colors.deepOrange),
              title: Text("View Event"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventListScreen()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context);
                ClearPreference('admin_token');
                Navigator.pushNamed(
                  context,
                  "/AdminLogin",
                );
              },
            ),
          ],
        ),
      ),
      body: Center(child: Text("ADMIN DESHBORD")),
    );
  }
}
