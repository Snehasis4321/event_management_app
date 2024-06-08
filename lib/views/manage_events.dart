import 'package:appwrite/models.dart';
import 'package:event_management_app/constants/colors.dart';
import 'package:event_management_app/database.dart';
import 'package:event_management_app/views/edit_event_page.dart';
import 'package:event_management_app/views/event_details.dart';
import 'package:flutter/material.dart';

class ManageEvents extends StatefulWidget {
  const ManageEvents({super.key});

  @override
  State<ManageEvents> createState() => _ManageEventsState();
}

class _ManageEventsState extends State<ManageEvents> {
  List<Document> userCreatedEvents = [];
  bool isLoading = true;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    manageEvents().then((value) {
      userCreatedEvents = value;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Events")),
      body: ListView.builder(
        itemCount: userCreatedEvents.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EventDetails(data: userCreatedEvents[index]))),
            title: Text(
              userCreatedEvents[index].data["name"],
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "${userCreatedEvents[index].data["participants"].length} Participants",
              style: TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditEventPage(
                              image: userCreatedEvents[index].data["image"],
                              name: userCreatedEvents[index].data["name"],
                              desc:
                                  userCreatedEvents[index].data["description"],
                              loc: userCreatedEvents[index].data["location"],
                              datetime:
                                  userCreatedEvents[index].data["datetime"],
                              guests: userCreatedEvents[index].data["guests"],
                              sponsers:
                                  userCreatedEvents[index].data["sponsers"],
                              isInPerson:
                                  userCreatedEvents[index].data["isInPerson"],
                              docID: userCreatedEvents[index].$id,
                            )));
                refresh();
              },
              icon: Icon(
                Icons.edit,
                color: kLightGreen,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
