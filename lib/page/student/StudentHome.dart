import 'package:flutter/material.dart';

class StudentHome extends StatefulWidget {
  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/1.PNG', // Path to your logo image
              height: 40,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "QR Attendance Management System",
                style: TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis, // Handle long text
              ),
            ),
          ],
        ),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, size: 30), // User profile icon
            onPressed: () {
              // Navigate to Profile Page
              _showSnackBar(context, "Navigating to Profile...");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20), // Space at the top
          Expanded(
            child: Container(
              width: double.infinity, // Full width of the screen
              child: Image.asset(
                'assets/images/1.png', // Path to your body image
                fit: BoxFit.cover, // Ensures the image covers the container
              ),
            ),
          ),
        ],
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
