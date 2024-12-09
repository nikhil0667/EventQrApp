//not output show

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event QR Attendance"),
        backgroundColor: Colors.deepOrange,
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
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("assets/images/banner.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Event Registration Section
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventRegistrationForm(),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.event, color: Colors.blue, size: 40),
                    title: Text(
                      "Register New Event",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Add a new event to the system"),
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: Colors.deepOrange),
                  ),
                ),
              ),
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
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: Colors.deepOrange),
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
              FutureBuilder(
                future: fetchUpcomingEvents(), // API call to Node.js backend
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text("Error fetching events");
                  }
                  final events = snapshot.data as List<Map<String, String>>;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.event, color: Colors.orange),
                          title: Text(event['name'] ?? ""),
                          subtitle: Text(event['date'] ?? ""),
                          trailing: Icon(Icons.arrow_forward_ios,
                              color: Colors.deepOrange),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EventDetailsPage(event: event),
                              ),
                            );
                          },
                        ),
                      );
                    },
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
  Future<List<Map<String, String>>> fetchUpcomingEvents() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate API delay
    return [
      {"name": "Flutter Workshop", "date": "2024-12-15"},
      {"name": "Tech Conference", "date": "2024-12-20"},
    ];
  }
}

// Event Registration Form Page
class EventRegistrationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController organizerController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Register Event"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Event Name"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: organizerController,
                decoration: InputDecoration(labelText: "Organizer"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: dateController,
                decoration: InputDecoration(labelText: "Event Date"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: "Location"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange),
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
                child: Text("Submit"),
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
  final Map<String, String> event;

  EventDetailsPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event['name'] ?? "Event Details"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Event: ${event['name'] ?? ""}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text("Organizer: ${event['organizer'] ?? ""}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Date: ${event['date'] ?? ""}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Location: ${event['location'] ?? ""}",
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Description: ${event['description'] ?? ""}",
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: HomePage()));
}
