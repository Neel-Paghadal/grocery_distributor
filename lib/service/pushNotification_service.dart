import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../ConstFile/constPreferences.dart';

class PushNotificationService {


  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    debugPrint('Title:  ${message.notification!.title}');
    debugPrint('Body:  ${message.notification!.body}');
    debugPrint('payload:  ${message.data}');
    String userID =
    message.data.toString().split(':')[1].trim().replaceAll('}', '');
    debugPrint("$userID userID");
  }

  void handleNotification() async {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        _handleMessage(message);
      }
    });
  }

  void _handleMessage(RemoteMessage message) {
    debugPrint('Handling message: $message');
    // Extract user ID from the message data
    String userID = message.data.toString().split(':')[1].trim().replaceAll('}', '');
    debugPrint("$userID userID");

  }

  Future initialize() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message Body: ${message.notification?.body}');
      debugPrint('Message Title: ${message.notification?.title}');
      // String userID = message.data.toString().split(':')[1].trim().replaceAll('}', '');
      // debugPrint("$userID userID");
      debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        debugPrint('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("Background message: $message");
      String userID = message.data.toString().split(':')[1].trim().replaceAll('}', '');
      debugPrint("$userID userID");

    });
  }

// Future<String?> getToken() async {
//   String? token = await _fcm.getToken();
//   debugPrint('Token: $token');
//   return token;
// }
}





// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_callkit_incoming/entities/entities.dart';
// import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
// import 'package:get/get.dart';
// import 'package:grocery_distributor/ConstFile/constPreferences.dart';
// import 'package:grocery_distributor/Controllers/home_controller.dart';
// import 'package:grocery_distributor/api_services/all_services.dart';
//
// class PushNotificationService {
//
//   int index = 0;
//
//   Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     await Firebase.initializeApp();
//     print('Title:  ${message.notification!.title}');
//     print('Body:  ${message.notification!.body}');
//     print('payload:  ${message.data}');
//     if (message.data.containsKey('userID')) {
//       String userID = message.data['userID'];
//       print('$userID userID');
//     } else {
//       print('userID key not found in the message data');
//     }
//
//   }
//
//
//
//
//   void handleNotification() async {
//     FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
//       if (message != null) {
//         // Handle the initial notification when the app is opened from a terminated state
//         _handleMessage(message);
//       }
//     });
//   }
//
//   void _handleMessage(RemoteMessage message) {
//     print('Handling message: $message');
//     // Extract user ID from the message data
//     String userID = message.data.toString().split(':')[1].trim().replaceAll('}', '');
//     print(userID+" userID");
//
//   }
//
//
//
//   Future initialize() async {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       debugPrint('Got a message whilst in the foreground!');
//       debugPrint('Message Body: ${message.notification?.body}');
//       debugPrint('Message Title: ${message.notification?.title}');
//       debugPrint('Message Data: ${ message.data}');
//       String userID = message.data.toString().split(':')[1].trim().replaceAll('}', '');
//       debugPrint("$userID userID");
//       debugPrint('Message data: ${message.data}');
//
//       if (message.notification != null) {
//         debugPrint('Message also contained a notification: ${message.notification}');
//       }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       debugPrint("Background message: $message");
//       String userID = message.data.toString().split(':')[1].trim().replaceAll('}', '');
//       debugPrint("$userID userID");
//
//     });
//   }
//
//
//
//
//   // Future<void> initialize() async {
//   //
//   //
//   //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//   //     print('Got a message whilst in the foreground!');
//   //     print('Message Title: ${message.notification?.title}');
//   //     print('Message Body: ${message.notification?.body}');
//   //     print('Message data: ${message.data}');
//   //     try {
//   //       if (message.data.containsKey('userID')) {
//   //         String userID = message.data['userID'];
//   //         print('$userID userID');
//   //
//   //       } else {
//   //         print('userID key not found in the message data');
//   //       }
//   //     } catch (e) {
//   //       print('Error parsing distributorID: $e');
//   //     }
//   //
//   //     if (message.notification != null) {
//   //       print('Message also contained a notification: ${message.notification}');
//   //     }
//   //
//   //   });
//   //
//   //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//   //     print("Background message: $message");
//   //     RemoteNotification? notification = message.notification;
//   //
//   //     if (notification != null) {
//   //       homeController.showAlarmDialog(index: index, title: notification.title.toString(), body: notification.body.toString(), imageUrl: '');
//   //     }
//   //
//   //     String userID = message.data.toString().split(':')[1].trim().replaceAll('}', '');
//   //     print(userID+" userID");
//   //   });
//   // }
//
//
//
//
// }