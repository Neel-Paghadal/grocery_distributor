import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/ConstFile/constPreferences.dart';
import 'package:grocery_distributor/Controllers/home_controller.dart';
import 'package:grocery_distributor/api_services/all_services.dart';

class PushNotificationService {
  // DetailController detailController = Get.put(DetailController());

  int index = 0;

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Title:  ${message.notification!.title}');
    print('Body:  ${message.notification!.body}');
    // print('imageurl: ${message.notification!.android!.imageUrl.toString()}');
    print('payload:  ${message.data}');
    if (message.data.containsKey('userID')) {
      String userID = message.data['userID'];
      print('$userID userID');
      // homeController.showAlarmDialog(index: index);
      homeController.showAlarmDialog(index: index, title: message.notification!.title.toString(), body: message.notification!.body.toString());
    } else {
      print('userID key not found in the message data');
    }
    /*String userID = message.data.toString().split(':')[1].trim().replaceAll('}', '');
    print(userID+" userID");*/
    // detailController.userId = userID;
    // detailController.detailCall(detailController.userId);
    // Get.to(()=>const NotificationDetailScreen());
  }

  /*Future<void> sendMessage(String targetUserId, String title, String body,) async {
    await FirebaseFirestore.instance.collection('messages').add({
      'to': targetUserId,
      'title': title,
      'body': body,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }*/

  // Future<void> initNotifications() async {
  //   await _fcm.requestPermission();
  //   final fCMToken  = await _fcm.getToken();
  //   debugPrint('Token $fCMToken');
  //   if(fCMToken!.isNotEmpty){
  //     ConstPreferences().setFcmToken(fCMToken);
  //   }
  //   // initialize();
  //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // }

  void handleNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        // Handle the initial notification when the app is opened from a terminated state
        _handleMessage(message);
      }
    });
  }

  void _handleMessage(RemoteMessage message) {
    print('Handling message: $message');
    // Extract user ID from the message data
    String userID = message.data.toString().split(':')[1].trim().replaceAll('}', '');
    print(userID+" userID");
    // detailController.userId = userID;
    // detailController.detailCall(detailController.userId);
    // Get.to(()=>const NotificationDetailScreen());
  }

  Future<void> initialize() async {
    // await Firebase.initializeApp();
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message Title: ${message.notification?.title}');
      print('Message Body: ${message.notification?.body}');
      print('Message data: ${message.data}');
      try {
        if (message.data.containsKey('userID')) {
          String userID = message.data['userID'];
          print('$userID userID');
          // detailController.userId = userID;
          // detailController.detailCall(detailController.userId);
          // Get.to(()=>const NotificationDetailScreen());
        } else {
          print('userID key not found in the message data');
        }
      } catch (e) {
        print('Error parsing distributorID: $e');
      }

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        // await audioPlayer.play(AssetSource('assets/ringtone.mp3'));

        // homeController.showAlarmDialog(index: index);
        homeController.showAlarmDialog(index: index, title: message.notification!.title.toString(), body: message.notification!.body.toString());
      }
    });

    /*FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message Body: ${message.notification?.body}');
      print('Message Title: ${message.notification?.title}');
      // print('Message image: ${message.notification?.android!.imageUrl.toString()}');
      String userID = message.data.toString().split(':')[1].trim().replaceAll('}', '');
      print(userID+" userID");
      // detailController.userId = userID;
      // detailController.detailCall(detailController.userId);
      // Get.to(()=>const NotificationDetailScreen());
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');

      }
    });*/

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Background message: $message");
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        // homeController.showAlarmDialog(index: index);
        homeController.showAlarmDialog(index: index, title: notification.title.toString(), body: notification.body.toString());
      }

      String userID = message.data.toString().split(':')[1].trim().replaceAll('}', '');
      print(userID+" userID");
      // detailController.userId = userID;
      // detailController.detailCall(detailController.userId);
      // Get.to(()=>const NotificationDetailScreen());
    });
  }

  // Future<String?> getToken() async {
  //   String? token = await _fcm.getToken();
  //   print('Token: $token');
  //   return token;
  // }
}