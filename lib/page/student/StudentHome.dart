//not output show

import 'dart:async';
import 'dart:math';

import 'package:eventifyQr/page/EventView.dart';
import 'package:eventifyQr/services/services.dart';
import 'package:eventifyQr/shared_Preference.dart';
import 'package:eventifyQr/snackBar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StudentHome extends StatefulWidget {
  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  var eventDetails = {};
  bool isloading = true;
  var count = 0;
  Future<void> getEvent() async {
    try {
      // Convert date fields to ISO 8601 format (if necessary)

      // Send data to API
      final response = await getEventData();

      if (response != null) {
        final status = response['body']['status'];
        final msg = response['body']['msg'];

        eventDetails = response['body'];

        print(eventDetails["events"]);
        count = eventDetails['events'].length;
        setState(() {
          isloading = false;
        });
        print(count);
        if (status == 200) {
          SnackBarMessage(context, true, msg);
        } else if (status == 500) {
          SnackBarMessage(context, false, "Internal Server Error");
        } else {
          SnackBarMessage(context, true, msg.toString());
        }
      } else {
        SnackBarMessage(context, false, "No response from the server");
      }
    } catch (error) {
      print(error); // Log the error for debugging
      SnackBarMessage(context, false, error.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEvent();
  }

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
                ClearPreference('student_token');
                Navigator.pushNamed(
                  context,
                  "/StudentLogin",
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Event QR Attendance"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, size: 30),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Profile/Settings")),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Banner

              SizedBox(height: 20),
              // Event Registration Section

              SizedBox(height: 15),
              // QR Attendance Section
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text("QR Attendance Scanning Coming Soon!")),
                  );
                },
                child: Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.qr_code, color: Colors.green, size: 40),
                    title: Text(
                      "QR Attendance",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Mark attendance via QR Code"),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 15),
              // Upcoming Events Section
              Text(
                "Upcoming Events",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              isloading
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: count,
                      itemBuilder: (context, index) {
                        final event = eventDetails['events'][index];
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.event, color: Colors.orange),
                            title: Text(event['eventName'] ?? ""),
                            subtitle: Text(DateFormat('dd-MM-yyyy').format(
                                    DateTime.parse(event['eventDate'])) ??
                                ""),
                            trailing: Icon(Icons.arrow_forward_ios,
                                color: Colors.blue),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EventDetailsPage(event: event),
                                ),
                              );
                              if (kDebugMode) {
                                print("WAIT THE " + event.toString());
                              }
                            },
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  // Mock API Call (Replace with your Node.js API call)
}

// Event Registration Form Page
class EventRegistrationForm extends StatelessWidget {
  var event;

  EventRegistrationForm({required this.event});

  @override
  Widget build(BuildContext context) {
    print("REGFIST : " + event.toString());
    final TextEditingController nameController =
        TextEditingController(text: event['eventName'].toString());
    final TextEditingController organizerController =
        TextEditingController(text: event['eventOrganizer'].toString());
    final TextEditingController dateController =
        TextEditingController(text: event['eventDate'].toString());
    final TextEditingController locationController =
        TextEditingController(text: event['location'].toString());
    final TextEditingController descriptionController =
        TextEditingController(text: event['description'].toString());

    return Scaffold(
      appBar: AppBar(
        title: Text("Register Event"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                readOnly: true,
                controller: nameController,
                decoration: InputDecoration(labelText: "Event Name"),
              ),
              SizedBox(height: 10),
              TextField(
                readOnly: true,
                controller: organizerController,
                decoration: InputDecoration(labelText: "Organizer"),
              ),
              SizedBox(height: 10),
              TextField(
                readOnly: true,
                controller: dateController,
                decoration: InputDecoration(labelText: "Event Date"),
              ),
              SizedBox(height: 10),
              TextField(
                readOnly: true,
                controller: locationController,
                decoration: InputDecoration(labelText: "Location"),
              ),
              SizedBox(height: 10),
              TextField(
                readOnly: true,
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  final eventDetails = {
                    "name": nameController.text,
                    "organizer": organizerController.text,
                    "date": dateController.text,
                    "location": locationController.text,
                    "description": descriptionController.text,
                  };
                  // Call your Node.js API to save the event
                  print("Event Registered: $eventDetails");
                  Navigator.pop(context);
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Event Details Page
class EventDetailsPage extends StatelessWidget {
  var event;

  EventDetailsPage({required this.event});

  @override
  Widget build(BuildContext context) {
    print(event['eventName']);
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentHome(),
                  ),
                ); // Close the drawer
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
                ClearPreference('student_token');
                Navigator.pushNamed(
                  context,
                  "/StudentLogin",
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(event['name'] ?? "Event Details"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Event: ${event['eventName'] ?? ""}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Organizer: ${event['eventOrganizer'] ?? ""}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Date: ${event['eventDate'] ?? ""}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Location: ${event['location'] ?? ""}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Description: ${event['description'] ?? ""}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                print("WEEEE " + event.toString());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventRegistrationForm(event: event),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Register event",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
