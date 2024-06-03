import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:grocery_distributor/api_services/all_services.dart';
import 'package:grocery_distributor/service/pushNotification_service.dart';

import 'Screens/splash.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  // 'This channel is used for important notifications.', // description
  description: 'This channel is used for important notifications',
  showBadge: true,
  importance: Importance.high,
  playSound: true,
);

  int index = 0;
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Title:  ${message.notification!.title}');
    print('Body:  ${message.notification!.body}');
    print('Imageurl: ${message.notification!.android!.imageUrl.toString()}');
    print('payload:  ${message.data}');
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Background message: $message");
      String userID = message.data.toString().split(':')[1].trim().replaceAll('}', '');
      print(userID+" userID");
      // homeController.showAlarmDialog(index: index);
      homeController.showAlarmDialog(index: index, title: message.notification!.title.toString(), body: message.notification!.body.toString());
      // detailController.userId = userID;
      // detailController.detailCall(detailController.userId);
      // Get.to(()=>const NotificationDetailScreen());
    });

  }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

  // await PushNotificationService().initNotifications();
  await PushNotificationService().initialize();
  PushNotificationService().handleNotification();

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

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
  // runApp(DevicePreview(
  //   builder: (context) => const MyApp(),
  //   enabled: true,
  // ));
}

// runApp(DevicePreview(
// builder:(context) =>  MyApp(),
// enabled: true,
//
// ));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // String? _deviceToken;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirebaseMessaging.instance.requestPermission();
      // getNotification();
      getnewNotifications();
    });
  }

  Future<void> getNotification() async {
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      var imageBytes = await getImageBytes(notification!.android!.imageUrl.toString());

      var largeIconBitmap =  ByteArrayAndroidBitmap(imageBytes);
      /*Get.snackbar("My app notification ", notification!.body.toString(),
          reverseAnimationCurve: Curves.bounceIn,
          forwardAnimationCurve: Curves.bounceInOut,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
          colorText: Colors.white,
          backgroundColor: ConstColor.primaryColor);*/

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
          notification!.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id, channel.name,
              channelDescription: channel.description,
              importance: Importance.high,
              largeIcon: largeIconBitmap,
              channelShowBadge: true,
              color: Colors.blue,
              playSound: true,
              enableVibration: true,
              ongoing: true,
              styleInformation: bigPictureStyleInformation,
              // icon: '@mipmap/ic_launcher',
              icon: '@drawable/wallpaper_icon',
              // icon: '@drawable/wallpaper',
            ),
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

  Future<void> getnewNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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

          var android = new AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.max,
            largeIcon: largeIconBitmap,
            channelShowBadge: true,
            // color: Colors.blue,
            playSound: true,
            enableVibration: true,
            ongoing: true,
            priority: Priority.high,
            styleInformation: bigPictureStyleInformation,
            // icon: '@mipmap/ic_launcher',
            icon: '@drawable/wallpaper_icon',
            /*"0",
            channel.name,
            channelDescription: channel.description,
            importance: Importance.max,
            priority: Priority.high,
            styleInformation: bigPictureStyleInformation,
            icon: '@mipmap/ic_launcher',
            // icon: '@drawable/wallpaper',*/
          );

          var platformChannelSpecifics = NotificationDetails(android: android);
          await flutterLocalNotificationsPlugin.show(
            0,
            notification.title,
            notification.body,
            platformChannelSpecifics,
            // payload: 'Custom_Sound'
          );

          /*int index = 0;

          homeController.showAlarmDialog(context, message.notification!.title, message.notification!.body, index);*/

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

  Future<void> _showNotification(String? title, String? body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@drawable/wallpaper'
    );
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics,);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,
        // new intail
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      // home:   LoginScreen(),
      // home:   SplashScreen(),
      //  home:   HomeScreen(),
      // home: LiveorderPage(),
      // home: DashbordPage(),
      // home: lowstockPage(),
      // home: GodownPage(),
    );
  }
}