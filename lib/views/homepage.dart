import 'package:appwrite/models.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:event_management_app/auth.dart';
import 'package:event_management_app/constants/colors.dart';
import 'package:event_management_app/containers/event_container.dart';

import 'package:event_management_app/database.dart';
import 'package:event_management_app/saved_data.dart';

import 'package:event_management_app/views/create_event_page.dart';
import 'package:event_management_app/views/event_details.dart';
import 'package:event_management_app/views/login.dart';
import 'package:event_management_app/views/popular_item.dart';
import 'package:event_management_app/views/profile_page.dart';

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String userName = "User";
  List<Document> events = [];
  bool isLoading = true;

  @override
  void initState() {
    userName = SavedData.getUserName().split(" ")[0];
    refresh();
    super.initState();
  }

  void refresh() {
    getAllEvents().then((value) {
      events = value;
      isLoading = false;
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
              onPressed: () async {
                // logoutUser();
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));

                refresh();
              },
              icon: Icon(
                Icons.account_circle,
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
                          fontWeight: FontWeight.w600)),
                  isLoading
                      ? const SizedBox()
                      : CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 5),
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.99,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: [
                            ...List.generate(4, (index) {
                              return EventContainer(
                                data: events[index],
                              );
                            }),
                          ],
                        ),
                  const SizedBox(height: 16),
                  Text(
                    "Popular Events ",
                    style: TextStyle(
                      color: kLightGreen,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                color: const Color(0xFF2E2E2E),
                child: isLoading
                    ? const SizedBox()
                    : Column(
                        children: [
                          for (int i = 0; i < events.length && i < 5; i++) ...[
                            PopularItem(
                              eventData: events[i],
                              index: i + 1,
                            ),
                            const Divider(),
                          ],
                        ],
                      ),
              )
            ]),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 2, top: 8, left: 6, right: 6),
              child: Text(
                "All Events",
                style: TextStyle(
                  color: kLightGreen,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => EventContainer(data: events[index]),
                  childCount: events.length)),
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
