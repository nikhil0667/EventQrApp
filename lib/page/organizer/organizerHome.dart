import 'package:eventifyQr/page/EventView.dart';
import 'package:eventifyQr/page/createEvent.dart';
import 'package:eventifyQr/shared_Preference.dart';
import 'package:flutter/material.dart';

class OrganizerHome extends StatefulWidget {
  @override
  State<OrganizerHome> createState() => _OrganizerHomeState();
}

class _OrganizerHomeState extends State<OrganizerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.blue,
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
              leading: Icon(Icons.home, color: Colors.blue),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.event, color: Colors.blue),
              title: Text("Create Event"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateEventPage(
                            type: "create",
                          )),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.event, color: Colors.blue),
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
              leading: Icon(Icons.logout, color: Colors.blue),
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context);
                ClearPreference('organizer_token');
                Navigator.pushNamed(
                  context,
                  "/Organizerlogin",
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                "QR Attendance Management System",
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis, // Handle long text
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          "Welcome to QR Attendance Management System",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Helper function to show Snackbar
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
