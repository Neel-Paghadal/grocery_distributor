import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/ConstFile/constColor.dart';
import 'package:grocery_distributor/Screens/splash.dart';

import 'service/pushNotification_service.dart';



final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "0", // id
  'High Importance Notifications', // title
  // 'This channel is used for important notifications.', // description
  description: 'This channel is used for important notifications',
  showBadge: true,
  importance: Importance.high,
  playSound: true,
);


Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Title:  ${message.notification!.title}');
  debugPrint('Body:  ${message.notification!.body}');
  debugPrint('payload:  ${message.data}');
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint("Background message: $message");
    // String userID = message.data.toString().split(':')[1].trim().replaceAll('}', '');
    // debugPrint(userID + " userID");

  });
}

void main() async {


  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await PushNotificationService().initialize();

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // runApp(DevicePreview(
  //   enabled: true,
  //   builder: (context) => MyApp(), // Wrap your app
  // ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  Future<void> getNotificaton() async {

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      var imageBytes = await getImageBytes(notification!.android!.imageUrl.toString());

      // Convert image bytes to an AndroidBitmap
      var largeIconBitmap =  ByteArrayAndroidBitmap(imageBytes);

      print("Notification received");
      // Get.snackbar("My app notification ", notification!.body.toString(),
      //     reverseAnimationCurve: Curves.bounceIn,
      //     forwardAnimationCurve: Curves.bounceInOut,
      //     snackPosition: SnackPosition.TOP,
      //     duration: const Duration(seconds: 2),
      //     colorText: Colors.white,
      //     backgroundColor: ConstColour.primaryColor);
      var bigPictureStyleInformation = BigPictureStyleInformation(
        largeIconBitmap,
        //   DrawableResourceAndroidBitmap(imageUrl),
        largeIcon: largeIconBitmap,
        contentTitle: notification.title,
        htmlFormatContentTitle: true,
        summaryText: notification.body,
        htmlFormatSummaryText: true,
      );
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails("0", channel.name,
                channelDescription: channel.description,
                importance: Importance.high,
                largeIcon:largeIconBitmap,
                channelShowBadge: true,
                color: Colors.blue,
                playSound: true,
                enableVibration: true,
                ongoing: true,
                styleInformation: bigPictureStyleInformation,
                // icon: '@drawable/notification_logo'),
            icon: '@mipmap/ic_launcher'),
          ));
    });
  }

  Future<Uint8List> getImageBytes(String imageUrl) async {
    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.parse(imageUrl));
    var response = await request.close();
    if (response.statusCode == 200) {
      return await consolidateHttpClientResponseBytes(response);
    } else {
      throw Exception('Failed to load image');
    }
  }

  Future<Uint8List> convertImageBytesToAndroidBitmap(Uint8List imageBytes) async {
    final Completer<Uint8List> completer = Completer();
    ui.decodeImageFromList(imageBytes, (ui.Image img) async {
      var byteData = await img.toByteData();
      var buffer = byteData!.buffer.asUint8List();
      completer.complete(buffer);
    });
    return completer.future;
  }

  Future<Uint8List> getImageBytes1(String imageUrl) async {
    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.parse(imageUrl));
    var response = await request.close();
    if (response.statusCode == 200) {
      return await consolidateHttpClientResponseBytes(response);
    } else {
      throw Exception('Failed to load image');
    }
  }

  Future<void> getnewNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        var imageUrl = notification.android!.imageUrl;
        if (imageUrl != null) {
          // var bigPictureStyleInformation = BigPictureStyleInformation(
          //   DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
          //   largeIcon: DrawableResourceAndroidBitmap(imageUrl),
          //   contentTitle: notification.title,
          //   htmlFormatContentTitle: true,
          //   summaryText: notification.body,
          //   htmlFormatSummaryText: true,
          // );
          // Define notification details
          // Fetch the image bytes from the URL
          var imageBytes = await getImageBytes(imageUrl);

          // Convert image bytes to an AndroidBitmap
          var largeIconBitmap =  ByteArrayAndroidBitmap(imageBytes);

          var bigPictureStyleInformation = BigPictureStyleInformation(
            largeIconBitmap,
            //   DrawableResourceAndroidBitmap(imageUrl),
            largeIcon: largeIconBitmap,
            contentTitle: notification.title,
            htmlFormatContentTitle: true,
            summaryText: notification.body,
            htmlFormatSummaryText: true,
          );
          var android = new AndroidNotificationDetails( "0",
              channel.name,
              channelDescription: channel.description,
              importance: Importance.max,
              priority: Priority.high,
              styleInformation: bigPictureStyleInformation,
              icon: '@mipmap/ic_launcher');

          var platformChannelSpecifics = NotificationDetails(android: android);
          await flutterLocalNotificationsPlugin.show(
            0,
            notification.title,
            notification.body,
            platformChannelSpecifics,
          );
          //  var iOS = new IOSNotificationDetails();
          //   var platform = new NotificationDetails(android: android);
          /*   await flutterLocalNotificationsPlugin.show(
              0, 'New Notification', 'Flutter Local Notif', platform,payload: 'test notification');*/

          /*    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
           "0",
            channel.name,
            channelDescription: channel.description,
            importance: Importance.max,
            priority: Priority.high,
            styleInformation: bigPictureStyleInformation,
              icon: '@mipmap/ic_launcher'
          );*/
          /*        var platformChannelSpecifics = NotificationDetails(
            android: androidPlatformChannelSpecifics,
          );*/
          /*await flutterLocalNotificationsPlugin.show(
            0,
          //  notification.hashCode,
            notification.title,
            notification.body,
            platformChannelSpecifics,
          );*/
        } else {
          // Handle notification without image
        }
      }
    });
  }


  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirebaseMessaging.instance.requestPermission();
      getNotificaton();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AayuPlus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(splashColor: Colors.white, useMaterial3: false),
      home: const SplashScreen(),
    );
  }
}







// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
// import 'package:flutter_callkit_incoming/entities/entities.dart';
// import 'package:flutter_callkit_incoming/entities/notification_params.dart';
// import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:grocery_distributor/ConstFile/constColor.dart';
// import 'package:grocery_distributor/api_services/all_services.dart';
// import 'package:grocery_distributor/service/pushNotification_service.dart';
// import 'Screens/splash.dart';
//
// //
// // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// //
// // const AndroidNotificationChannel channel = AndroidNotificationChannel(
// //   "0", // id
// //   'High Importance Notifications', // title
// //   // 'This channel is used for important notifications.', // description
// //   description: 'This channel is used for important notifications',
// //   showBadge: true,
// //   importance: Importance.high,
// //   playSound: true,
// // );
// //
// //
// // Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// //   await Firebase.initializeApp();
// //   debugPrint('Title:  ${message.notification!.title}');
// //   debugPrint('Body:  ${message.notification!.body}');
// //   debugPrint('payload:  ${message.data}');
// //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
// //     debugPrint("Background message: $message");
// //     String userID =
// //     message.data.toString().split(':')[1].trim().replaceAll('}', '');
// //     debugPrint(userID + " userID");
// //
// //   });
// // }
// //
// // void main() async {
// //
// //
// //   WidgetsFlutterBinding.ensureInitialized();
// //
// //   await Firebase.initializeApp();
// //   SystemChrome.setPreferredOrientations([
// //     DeviceOrientation.portraitUp,
// //     DeviceOrientation.portraitDown,
// //   ]);
// //
// //   await PushNotificationService().initialize();
// //   PushNotificationService().handleNotification();
// //
// //   await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
// //   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
// //     alert: true,
// //     badge: true,
// //     sound: true,
// //   );
// //
// //   await FirebaseMessaging.instance.requestPermission(
// //     alert: true,
// //     announcement: false,
// //     badge: true,
// //     carPlay: false,
// //     criticalAlert: false,
// //     provisional: false,
// //     sound: true,
// //   );
// //
// //   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
// //
// //   // runApp(DevicePreview(
// //   //   enabled: true,
// //   //   builder: (context) => MyApp(), // Wrap your app
// //   // ));
// //   runApp(const MyApp());
// // }
//
//
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   "0", // id
//   'High Importance Notifications', // title
//   // 'This channel is used for important notifications.', // description
//   description: 'This channel is used for important notifications',
//   showBadge: true,
//   importance: Importance.high,
//   playSound: true,
// );
//
//
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   debugPrint('Title:  ${message.notification!.title}');
//   debugPrint('Body:  ${message.notification!.body}');
//   debugPrint('payload:  ${message.data}');
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     debugPrint("Background message: $message");
//     String userID =
//     message.data.toString().split(':')[1].trim().replaceAll('}', '');
//     debugPrint(userID + " userID");
//
//   });
// }
//
// void main() async {
//
//
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Firebase.initializeApp();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//
//   await PushNotificationService().initialize();
//   PushNotificationService().handleNotification();
//
//   await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//
//   await FirebaseMessaging.instance.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//
//   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//
//   // runApp(DevicePreview(
//   //   enabled: true,
//   //   builder: (context) => MyApp(), // Wrap your app
//   // ));
//   runApp(const MyApp());
// }
//
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//
//   Future<void> getNotificaton() async {
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       RemoteNotification? notification = message.notification;
//
//       var imageBytes = await getImageBytes(notification!.android!.imageUrl.toString());
//
//       // Convert image bytes to an AndroidBitmap
//       var largeIconBitmap =  ByteArrayAndroidBitmap(imageBytes);
//
//       print("Notification received");
//       // Get.snackbar("My app notification ", notification!.body.toString(),
//       //     reverseAnimationCurve: Curves.bounceIn,
//       //     forwardAnimationCurve: Curves.bounceInOut,
//       //     snackPosition: SnackPosition.TOP,
//       //     duration: const Duration(seconds: 2),
//       //     colorText: Colors.white,
//       //     backgroundColor: ConstColour.primaryColor);
//       var bigPictureStyleInformation = BigPictureStyleInformation(
//         largeIconBitmap,
//         //   DrawableResourceAndroidBitmap(imageUrl),
//         largeIcon: largeIconBitmap,
//         contentTitle: notification.title,
//         htmlFormatContentTitle: true,
//         summaryText: notification.body,
//         htmlFormatSummaryText: true,
//       );
//       flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails("0", channel.name,
//                 channelDescription: channel.description,
//                 importance: Importance.high,
//                 largeIcon:largeIconBitmap,
//                 channelShowBadge: true,
//                 color: Colors.blue,
//                 playSound: true,
//                 enableVibration: true,
//                 ongoing: true,
//                 styleInformation: bigPictureStyleInformation,
//                 // icon: '@drawable/notification_logo'),
//             icon: '@mipmap/ic_launcher'),
//           ));
//     });
//   }
//   Future<Uint8List> getImageBytes(String imageUrl) async {
//     var httpClient = HttpClient();
//     var request = await httpClient.getUrl(Uri.parse(imageUrl));
//     var response = await request.close();
//     if (response.statusCode == 200) {
//       return await consolidateHttpClientResponseBytes(response);
//     } else {
//       throw Exception('Failed to load image');
//     }
//   }
//
//
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       FirebaseMessaging.instance.requestPermission();
//       getNotificaton();
//     });
//     super.initState();
//   }
//
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   WidgetsBinding.instance.addPostFrameCallback((_) {
//   //     FirebaseMessaging.instance.requestPermission();
//   //     getnewNotifications();
//   //   });
//   // }
//
//
//
//
//   // Future<Uint8List> getImageBytes(String imageUrl) async {
//   //   var httpClient = HttpClient();
//   //   var request = await httpClient.getUrl(Uri.parse(imageUrl));
//   //   var response = await request.close();
//   //   if (response.statusCode == 200) {
//   //     return await consolidateHttpClientResponseBytes(response);
//   //   } else {
//   //     throw Exception('Failed to load image');
//   //   }
//   // }
//
//   // Future<void> getnewNotifications() async {
//   //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   //
//   //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//   //     RemoteNotification? notification = message.notification;
//   //     AndroidNotification? android = message.notification?.android;
//   //
//   //     if (notification != null && android != null) {
//   //       var imageUrl = notification.android!.imageUrl;
//   //       if (imageUrl != null) {
//   //         var imageBytes = await getImageBytes(imageUrl);
//   //
//   //         // Convert image bytes to an AndroidBitmap
//   //         var largeIconBitmap =  ByteArrayAndroidBitmap(imageBytes);
//   //
//   //         var bigPictureStyleInformation = BigPictureStyleInformation(
//   //           largeIconBitmap,
//   //           //   DrawableResourceAndroidBitmap(imageUrl),
//   //           largeIcon: largeIconBitmap,
//   //           contentTitle: notification.title,
//   //           htmlFormatContentTitle: true,
//   //           summaryText: notification.body,
//   //           htmlFormatSummaryText: true,
//   //         );
//   //
//   //         var android = new AndroidNotificationDetails(
//   //           channel.id,
//   //           channel.name,
//   //           channelDescription: channel.description,
//   //           importance: Importance.max,
//   //           largeIcon: largeIconBitmap,
//   //           channelShowBadge: true,
//   //           // color: Colors.blue,
//   //           playSound: true,
//   //           enableVibration: true,
//   //           ongoing: true,
//   //           priority: Priority.high,
//   //           styleInformation: bigPictureStyleInformation,
//   //           icon: '@drawable/wallpaper',
//   //           // icon: '@mipmap/ic_launcher',
//   //           // icon: '@drawable/wallpaper_icon',
//   //           /*"0",
//   //           channel.name,
//   //           channelDescription: channel.description,
//   //           importance: Importance.max,
//   //           priority: Priority.high,
//   //           styleInformation: bigPictureStyleInformation,
//   //           icon: '@mipmap/ic_launcher',
//   //           // icon: '@drawable/wallpaper',*/
//   //         );
//   //
//   //         var platformChannelSpecifics = NotificationDetails(android: android);
//   //         await flutterLocalNotificationsPlugin.show(
//   //           0,
//   //           notification.title,
//   //           notification.body,
//   //           platformChannelSpecifics,
//   //           // payload: 'Custom_Sound'
//   //         );
//   //       } else {
//   //         // Handle notification without image
//   //       }
//   //     }
//   //   });
//   // }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         useMaterial3: false,
//         // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         // useMaterial3: true,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: const SplashScreen(),
//
//     );
//   }
// }
//
//
//
