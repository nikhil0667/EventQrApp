import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eventifyQr/services/services.dart';
import 'package:eventifyQr/snackBar.dart';
import 'package:flutter/material.dart';

class CreateEventPage extends StatefulWidget {
  String type = "";
  var event;

  CreateEventPage({required this.type, this.event});
  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  late bool isCreate;
  final TextEditingController eventNameController = TextEditingController();

  final TextEditingController organizerController = TextEditingController();

  final TextEditingController eventDateController = TextEditingController();

  final TextEditingController startRegController = TextEditingController();

  final TextEditingController endRegController = TextEditingController();

  final TextEditingController locationController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController eventPosterController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Access arguments passed to the StatefulWidget
    isCreate = widget.type == "create";

    if (!isCreate && widget.event != null) {
      // Populate fields for editing an event
      eventNameController.text = widget.event['eventName'] ?? "";
      eventPosterController.text = widget.event['event_poster'] ?? "";
      organizerController.text = widget.event['eventOrganizer'] ?? "";
      eventDateController.text = widget.event['eventDate'] ?? "";
      startRegController.text = widget.event['startRegistration'] ?? "";
      endRegController.text = widget.event['endRegistration'] ?? "";
      locationController.text = widget.event['location'] ?? "";
      descriptionController.text = widget.event['description'] ?? "";
    }
  }

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
      String eventDate =
          DateTime.parse(eventDateController.text).toIso8601String();
      String startRegistration =
          DateTime.parse(startRegController.text).toIso8601String();
      String endRegistration =
          DateTime.parse(endRegController.text).toIso8601String();

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
    Navigator.pop(context);
  }

  Future<void> updateEvent({required id}) async {
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
      String eventDate =
          DateTime.parse(eventDateController.text).toIso8601String();
      String startRegistration =
          DateTime.parse(startRegController.text).toIso8601String();
      String endRegistration =
          DateTime.parse(endRegController.text).toIso8601String();

      // Send data to API
      final response = await getEventUpdate({
        "eventName": eventNameController.text ?? "",
        "event_poster": eventPosterController.text ?? "",
        "eventOrganizer": organizerController.text ?? "",
        "eventDate": eventDate,
        "startRegistration": startRegistration,
        "endRegistration": endRegistration,
        "location": locationController.text ?? "",
        "description": descriptionController.text ?? "",
      }, id);

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
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    print("EVEN " + widget.event.toString());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Text(
          widget.type.toString() == 'create'
              ? "Event Registration"
              : "Update Event",
          style: const TextStyle(color: Colors.white),
        ),
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
                widget.type.toString() == 'create'
                    ? createEvent()
                    : updateEvent(id: widget.event['event_id']);
              },
              child: Text(
                widget.type.toString() == 'create' ? "Submit" : "Update",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
