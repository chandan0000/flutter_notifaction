import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notifaction/services/local_notification.dart';
import 'package:flutter_notifaction/services/local_notification.dart';
import 'package:flutter_notifaction/services/notification_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationController.initializeLocalNotifications(debug: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Notification',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: "Notification"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    log("int metthod");
    NotificationController.initializeNotificationsEventListeners();
    super.initState();
  }

  // triggerNotification() {
  //   AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: 10,
  //       channelKey: "basic_channel",
  //       title: "simple Notification",
  //       body: "Simple Button",
  //       bigPicture:
  //           "https://images.unsplash.com/photo-1679108896566-16e7b70c6ff8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  //       notificationLayout: NotificationLayout.BigPicture,
  //     ),
  //   );
  // }

  // scheduleNotification() {
  //   AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: 10,
  //       channelKey: "basic_channel",
  //       title: "simple Notification",
  //       body: "Simple Button",
  //       bigPicture:
  //           "https://images.unsplash.com/photo-1679108896566-16e7b70c6ff8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
  //       notificationLayout: NotificationLayout.BigPicture,
  //     ),
  //     schedule: NotificationCalendar.fromDate(
  //       date: DateTime.now().add(
  //         const Duration(seconds: 10),
  //       ),
  //       preciseAlarm: true,
  //       allowWhileIdle: true,
  //       repeats: true,
  //     ),
  //   );
  // }

  // cancelScheduleNotification(int id) async {
  //   await AwesomeNotifications().cancelSchedule(id);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                LocalNotification.createMessagingNotification(
                    channelKey: "chats",
                    groupKey: "Emma_group",
                    chatName: "Emma Group",
                    username: "Emma",
                    message: "Emmas has send a message",
                    largeIcon: "asset://assets/profile_photo_2.jpg");
              },
              child: const Text("Chat Notification"),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     LocalNotification.cancelScheduleNotification(10);
            //   },
            //   child: const Text("Cancel Schedule Notification"),
            // ),
          ],
        ),
      ),
    );
  }
}
