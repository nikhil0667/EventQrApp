import 'package:eventifyQr/page/createEvent.dart';
import 'package:eventifyQr/services/services.dart';
import 'package:eventifyQr/snackBar.dart';
import 'package:flutter/material.dart';

class EventListScreen extends StatefulWidget {
  bool isView = false;

  EventListScreen({
    this.isView = false,
  });
  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  var eventDetails = {};
  bool isloading = true;
  bool isDeleting = false;
  var count = 0;
  Future<void> getEvent() async {
    try {
      // Convert date fields to ISO 8601 format (if necessary)
      setState(() {
        isloading = true;
      });
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

  Future<void> deleteEventData(id) async {
    try {
      setState(() {
        isDeleting = true; // Show loader
      });
      final response = await deleteEvent(id);

      if (response != null) {
        final status = response['body']['status'];
        final msg = response['body']['msg'];

        print(count);
        if (status == 200) {
          await getEvent();
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
    } finally {
      setState(() {
        isDeleting = false; // Hide loader
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Text(
          "View Event",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange, // Changed color
      ),
      body: isloading || isDeleting
          ? Center(child: CircularProgressIndicator())
          : count <= 0
              ? Center(
                  child: Text("NO EVENT "),
                )
              : ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, index) {
                    final event = eventDetails['events'][index];
                    return InkWell(
                      onTap: () {
                        widget.isView
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateEventPage(
                                          type: "update",
                                          event: event,
                                        )),
                              )
                            : () {};
                      },
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: Image.network(
                            event['event_poster'] ?? "",
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                          title: Row(
                            children: [
                              Text(
                                event["eventName"] ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              widget.isView
                                  ? IconButton(
                                      onPressed: () {
                                        deleteEventData(event['event_id']);
                                      },
                                      icon: Icon(Icons.delete))
                                  : SizedBox()
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Organizer: ${event['eventOrganizer'] ?? ""}"),
                              Text("Date: ${event['eventDate'] ?? ""}"),
                              Text("Location: ${event['location'] ?? ""}"),
                              Text(
                                  "Description: ${event['description'] ?? ""}"),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
