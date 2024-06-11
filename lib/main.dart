import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:grocery_distributor/service/pushNotification_service.dart';
import 'package:system_alert_window/system_alert_window.dart';

import 'Screens/splash.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

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

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
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

  runApp(const MyApp());
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomOverlay(),
    ),
  );
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirebaseMessaging.instance.requestPermission();
      getNotification();
      SystemAlertWindow.checkPermissions();

    });
    super.initState();
  }

  Future<void> getNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      var imageBytes = await getImageBytes(notification!.android!.imageUrl.toString());

      // Convert image bytes to an AndroidBitmap
      var largeIconBitmap = ByteArrayAndroidBitmap(imageBytes);

      print("Notification received");
      var bigPictureStyleInformation = BigPictureStyleInformation(
        largeIconBitmap,
        //   DrawableResourceAndroidBitmap(imageUrl),
        largeIcon: largeIconBitmap,
        contentTitle: notification.title,
        htmlFormatContentTitle: true,
        summaryText: notification.body,
        htmlFormatSummaryText: true,
      );

      // AudioManager.instance.showOverlayWindow();
      showOverlayWindow();
      // CustomOverlay();
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails("0",
                channel.name,
                channelDescription: channel.description,
                importance: Importance.high,
                largeIcon: largeIconBitmap,
                channelShowBadge: true,
                color: Colors.white,
                playSound: true,
                enableVibration: true,
                ongoing: true,
                styleInformation: bigPictureStyleInformation,
                // icon: '@drawable/notification_logo'),
                icon: '@mipmap/launcher_icon'),
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



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      // home: MyAppss(),
    );
  }
}
