import 'package:eventifyQr/services/services.dart';
import 'package:eventifyQr/shared_Preference.dart';
import 'package:eventifyQr/snackBar.dart';
import 'package:flutter/material.dart';

class CreateEventPage extends StatefulWidget {
  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final TextEditingController eventNameController = TextEditingController();

  final TextEditingController organizerController = TextEditingController();

  final TextEditingController eventDateController = TextEditingController();

  final TextEditingController startRegController = TextEditingController();

  final TextEditingController endRegController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController eventPosterController = TextEditingController();
  Future<void> createEvent() async {
    // Check if any required field is empty or null
    if (eventNameController.text.isEmpty ||
        eventPosterController.text.isEmpty ||
        organizerController.text.isEmpty ||
        eventDateController.text.isEmpty ||
        startRegController.text.isEmpty ||
        endRegController.text.isEmpty ||
        locationController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      SnackBarMessage(context, false, "All fields are required.");
      return;
    }

    try {
      // Convert date fields to ISO 8601 format (if necessary)
      String eventDate =
          DateTime.parse(eventDateController.text).toIso8601String();
      String startRegistration =
          DateTime.parse(startRegController.text).toIso8601String();
      String endRegistration =
          DateTime.parse(endRegController.text).toIso8601String();

      // Log data before sending to API
      print({
        "eventName": eventNameController.text ?? "",
        "event_poster": eventPosterController.text ?? "",
        "eventOrganizer": organizerController.text ?? "",
        "eventDate": eventDate,
        "startRegistration": startRegistration,
        "endRegistration": endRegistration,
        "location": locationController.text ?? "",
        "description": descriptionController.text ?? "",
      });

      // Send data to API
      final response = await setcreateEvent({
        "eventName": eventNameController.text ?? "",
        "event_poster": eventPosterController.text ?? "",
        "eventOrganizer": organizerController.text ?? "",
        "eventDate": eventDate,
        "startRegistration": startRegistration,
        "endRegistration": endRegistration,
        "location": locationController.text ?? "",
        "description": descriptionController.text ?? "",
      });

      if (response != null) {
        final status = response['body']['status'];
        final msg = response['body']['msg'];
        print(response);

        if (status == 200) {
          SnackBarMessage(context, true, msg);
        } else if (status == 500) {
          SnackBarMessage(context, false, "Internal Server Error");
        } else {
          SnackBarMessage(context, false, msg.toString());
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
            TextField(
              controller: eventPosterController,
              decoration: const InputDecoration(
                labelText: "Event Poster",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            // Event Organizer

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
                createEvent();
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
