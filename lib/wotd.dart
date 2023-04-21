import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wotd_kiet/iotw.dart';
import 'package:wotd_kiet/services/local_notification_service.dart';
import 'package:wotd_kiet/view_idioms.dart';

import 'package:wotd_kiet/view_words.dart';
import 'package:home_widget/home_widget.dart';

class Wotd extends StatefulWidget {
  const Wotd({super.key});

  @override
  State<Wotd> createState() => _WotdState();
}

class _WotdState extends State<Wotd> {
  var data = FirebaseFirestore.instance
      .collection("words")
      .limit(1)
      .orderBy('date', descending: true)
      .snapshots();
  String word = " ", newWord = " ";
  LocalNotificationService notificationServices = LocalNotificationService();

  @override
  void initState() {
    super.initState();

    notificationServices.requestNotificationPermission();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("WORD of THE DAY"),
      ),
      drawer: Drawer(
          backgroundColor: Theme.of(context).backgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                  height: 200,
                  width: 200,
                  child: Image(image: AssetImage('assets/kiet.png'))),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: ListTile(
                    title: const Text(
                      'Idiom',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Iotw()));
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: ListTile(
                    title: const Text(
                      'View Words',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ViewWords()));
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: ListTile(
                    title: const Text(
                      'View Idioms',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewIdioms()));
                    },
                  ),
                ),
              ),
            ],
          )),
      body: Stack(children: [
        StreamBuilder(
          stream: data,
          builder: ((context, snapshot) {
            if (!snapshot.hasData)
              return const Center(child: CircularProgressIndicator());

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, int index) {
                HomeWidget.saveWidgetData<String>(
                    '_counterText', snapshot.data!.docs[index]['word']);
                HomeWidget.saveWidgetData<String>(
                    '_abc', snapshot.data!.docs[index]['meaning']);
                HomeWidget.updateWidget(
                    name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');

                word = snapshot.data!.docs[index]['word'];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: snapshot.data!.docs[index]['word'] + '\n',
                            style: GoogleFonts.meriendaOne(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                            children: [
                              TextSpan(
                                text: "(" +
                                    snapshot.data!.docs[index]['eg2'] +
                                    ")",
                                // ignore: prefer_const_constructors
                                style: GoogleFonts.pangolin(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Text(
                            "meaning:",
                            style: GoogleFonts.pangolin(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(
                          snapshot.data!.docs[index]['meaning'],
                          style: GoogleFonts.kalam(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Text(
                            "example:",
                            style: GoogleFonts.pangolin(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Text(
                          snapshot.data!.docs[index]['eg1'],
                          style: GoogleFonts.kalam(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ]),
    );
  }
}
