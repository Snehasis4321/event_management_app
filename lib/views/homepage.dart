import 'package:appwrite/models.dart';
import 'package:event_management_app/auth.dart';
import 'package:event_management_app/constants/colors.dart';
import 'package:event_management_app/containers/event_container.dart';

import 'package:event_management_app/database.dart';
import 'package:event_management_app/saved_data.dart';

import 'package:event_management_app/views/create_event_page.dart';
import 'package:event_management_app/views/event_details.dart';
import 'package:event_management_app/views/login.dart';

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String userName = "User";
  List<Document> events = [];
  @override
  void initState() {
    userName = SavedData.getUserName().split(" ")[0];
    refresh();
    super.initState();
  }

  void refresh() {
    getAllEvents().then((value) {
      events = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                logoutUser();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(
                Icons.logout,
                color: kLightGreen,
                size: 30,
              ))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi ${userName} 👋",
                    style: TextStyle(
                        color: kLightGreen,
                        fontSize: 32,
                        fontWeight: FontWeight.w600),
                  ),
                  Text("Expore event around you",
                      style: TextStyle(
                          color: kLightGreen,
                          fontSize: 16,
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => EventContainer(data: events[index]),
                  childCount: events.length))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateEventPage()));
          refresh();
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: kLightGreen,
      ),
    );
  }
}
