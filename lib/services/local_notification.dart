import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';

int createUniqueID(int maxValue) {
  Random random = Random();
  return random.nextInt(maxValue);
}

class LocalNotification {
  static scheduleNotification() async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: 'Simple Notification',
          body: 'Simple Button',
          bigPicture:
              "https://images.unsplash.com/photo-1519114056088-b877fe073a5e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1033&q=80",
          notificationLayout: NotificationLayout.BigPicture,
        ),
        schedule: NotificationCalendar(
          // weekday: 1,
          // hour: 19,
          // minute: 30,
          second: 0,
          repeats: true,
        ));
  }

  // action button
  static Future<void> showNotificationWithActionButton(int id) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: "basic_channel",
        title: "Anonymouse says",
        body: "Hi there",
        // bigPicture:
      ),
      actionButtons: [
        NotificationActionButton(
            key: "SUBSCRIBE", label: "Subscribe", autoDismissible: true),
        // NotificationActionButton(
        //   key: "READ",
        //   label: "Mark as read",
        //   requireInputText: true,
        //   autoDismissible: true,
        // ),
        NotificationActionButton(
          key: "DISMISS",
          label: "Dismiss",
          actionType: ActionType.Default,
          isDangerousOption: true,
        ),
      ],
    );
  }

  // Chat Notification
  static Future<void> createMessagingNotification({
    required String channelKey,
    required String groupKey,
    required String chatName,
    required String username,
    required String message,
    String? largeIcon,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueID(AwesomeNotifications.maxID),
        groupKey: groupKey,
        channelKey: channelKey,
        summary: chatName,
        title: username,
        body: message,
        largeIcon: largeIcon,
        notificationLayout: NotificationLayout.MessagingGroup,
        category: NotificationCategory.Message,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'REPLY',
          label: 'Reply',
          requireInputText: true,
          autoDismissible: false,
        ),
        NotificationActionButton(
          key: 'READ',
          label: 'Mark as Read',
          autoDismissible: true,
        )
      ],
    );
  }

  static cancelScheduleNotification(int id) async {
    await AwesomeNotifications().cancelSchedule(id);
  }
}
