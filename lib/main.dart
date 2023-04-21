import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workmanager/workmanager.dart';

import 'package:wotd_kiet/services/local_notification_service.dart';

import 'package:wotd_kiet/wotd.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('words')
        .orderBy("date", descending: true)
        .limit(1)
        .get();

    Map<String, dynamic> mp = snapshot.docs.first.data();

    // Pass data to home widget
    HomeWidget.saveWidgetData<String>(
      '_counterText',
      mp["word"]
    );
    HomeWidget.saveWidgetData<String>('_abc', mp["meaning"]);
    HomeWidget.updateWidget(
        name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerPeriodicTask(
    "1",
    "bgtask",
    frequency: const Duration(minutes: 15),
    inputData: {},
  );

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Color.fromARGB(255, 7, 7, 7),
      ),
      home: const Wotd(),
    );
  }
}
