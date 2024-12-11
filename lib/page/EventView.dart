import 'package:eventifyQr/page/createEvent.dart';
import 'package:eventifyQr/services/services.dart';
import 'package:eventifyQr/snackBar.dart';
import 'package:flutter/material.dart';

class EventListScreen extends StatefulWidget {
  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
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
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: count,
              itemBuilder: (context, index) {
                final event = eventDetails['events'][index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateEventPage(
                                type: "update",
                                event: event,
                              )),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: Image.network(
                        event['event_poster'] ?? "",
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                      title: Text(
                        event["eventName"] ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Organizer: ${event['eventOrganizer'] ?? ""}"),
                          Text("Date: ${event['eventDate'] ?? ""}"),
                          Text("Location: ${event['location'] ?? ""}"),
                          Text("Description: ${event['description'] ?? ""}"),
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
