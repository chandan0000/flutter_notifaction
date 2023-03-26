import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'local_notification.dart';

class NotificationController extends ChangeNotifier {
  // SINGLETON PATTERN
  static final NotificationController _instance =
      NotificationController._internal();

  factory NotificationController() {
    return _instance;
  }

  NotificationController._internal();

// INITIALIZATION METHOD

  static Future<void> initializeLocalNotifications(
      {required bool debug}) async {
    await AwesomeNotifications().initialize(
      null,
      // 'resource://drawable/res_naruto.png',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          importance: NotificationImportance.Max,
          // defaultPrivacy: NotificationPrivacy.Secret,
          enableVibration: true,
          defaultColor: Colors.redAccent,
          channelShowBadge: true,
          enableLights: true,
          // icon: 'resource://drawable/res_naruto',
          // playSound: true,
          // soundSource: 'resource://raw/naruto_jutsu',
        ),
        NotificationChannel(
          channelGroupKey: "chat_tests",
          channelKey: "chats",
          channelName: "Group chats",
          channelDescription:
              'This is a simple example channel of a chat group',
          channelShowBadge: true,
          importance: NotificationImportance.Max,
        ), 

      ],
      debug: debug,
    );
  }

  // event listner
  // Event Listener

  static Future<void> initializeNotificationsEventListeners() async {
    // Only after at least the action method is set, the notification events are delivered
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    bool isSilentAction =
        receivedAction.actionType == ActionType.SilentAction ||
            receivedAction.actionType == ActionType.SilentBackgroundAction;

    debugPrint(
        "${isSilentAction ? 'silent action' : 'Action'} notification recevied");

    log("recivedAction : ${receivedAction.toString()}");

   if(receivedAction.channelKey=="chats"){
          receiveChatNotificationAction(receivedAction);
   }
   
    Fluttertoast.showToast(
      msg:
          '${isSilentAction ? 'silent action' : 'Action'}  notification recevied',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.blue,
      gravity: ToastGravity.BOTTOM,
    );
  }
    static Future<void> receiveChatNotificationAction(
      ReceivedAction receivedAction) async {
    // print("recevied Action : ${receivedAction.toString()}");
    if (receivedAction.buttonKeyPressed == 'REPLY') {
      await LocalNotification.createMessagingNotification(
        channelKey: 'chats',
        groupKey: receivedAction.groupKey!,
        chatName: receivedAction.summary!,
        username: 'you',
        largeIcon:
            "https://images.unsplash.com/photo-1619895862022-09114b41f16f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
        message: receivedAction.buttonKeyInput,
      );
    } else {
      // navigate to the user chat page via routing
      // router parmerter be like => /chat/{nayan}
    }
  }


  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedAction) async {
    debugPrint("Notification created");

    Fluttertoast.showToast(
      msg: 'Notification created ',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.blue,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedAction) async {
    debugPrint("Notification displayed");

    Fluttertoast.showToast(
      msg: 'Notification displayed ',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.blue,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint("Notification dismiss");

    Fluttertoast.showToast(
      msg: 'Notification dismiss ',
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.blue,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
