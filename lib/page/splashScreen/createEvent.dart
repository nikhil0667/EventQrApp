import 'package:flutter/material.dart';

class CreateEventPage extends StatelessWidget {
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController organizerController = TextEditingController();
  final TextEditingController eventDateController = TextEditingController();
  final TextEditingController startRegController = TextEditingController();
  final TextEditingController endRegController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Registration"),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Name
            TextField(
              controller: eventNameController,
              decoration: const InputDecoration(
                labelText: "Event Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            // Event Organizer
            TextField(
              controller: organizerController,
              decoration: const InputDecoration(
                labelText: "Event Organizer",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            // Event Date
            TextField(
              controller: eventDateController,
              decoration: const InputDecoration(
                labelText: "Event Date",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  eventDateController.text =
                      pickedDate.toString().split(' ')[0];
                }
              },
            ),
            const SizedBox(height: 15),
            // Start Registration
            TextField(
              controller: startRegController,
              decoration: const InputDecoration(
                labelText: "Start Registration",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  startRegController.text = pickedDate.toString().split(' ')[0];
                }
              },
            ),
            const SizedBox(height: 15),
            // End Registration
            TextField(
              controller: endRegController,
              decoration: const InputDecoration(
                labelText: "End Registration",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  endRegController.text = pickedDate.toString().split(' ')[0];
                }
              },
            ),
            const SizedBox(height: 15),
            // Location
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: "Location",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            // Description
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            // Submit Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                final eventDetails = {
                  "name": eventNameController.text,
                  "organizer": organizerController.text,
                  "date": eventDateController.text,
                  "startRegistration": startRegController.text,
                  "endRegistration": endRegController.text,
                  "location": locationController.text,
                  "description": descriptionController.text,
                };
                print("Event Details: $eventDetails");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Event Registered Successfully!")),
                );
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
