import 'dart:async';
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

import 'Model/get_notification_model.dart';
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
  debugPrint('Image: ${message.notification!.android!.imageUrl}');
  debugPrint('payload:  ${message.data}');
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   debugPrint("Background message: $message");
  //   String userID = message.data.toString().split(':')[1].trim().replaceAll('}', '');
  //   debugPrint(userID + " userID");
  if (message.notification != null) {
    AudioManager.instance.showOverlayWindow();
  }
  // });
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

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   // 'This channel is used for important notifications.', // description
//   description: 'This channel is used for important notifications',
//   showBadge: true,
//   importance: Importance.high,
//   playSound: true,
// );
//
// int _overlayIndex = 0;
// String _overlayTitle = "";
// String _overlayBody = "";
// String _overlayImageUrl = "";
// String _overlayAddress = "";
// String _overlayUnit = "";
// String _overlayQuantity = "";
// String _overlayPrice = "";
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('Title:  ${message.notification!.title}');
//   print('Body:  ${message.notification!.body}');
//   print('Imageurl: ${message.notification!.android!.imageUrl.toString()}');
//   print('payload:  ${message.data}');
//
//   /*_overlayIndex = 0;
//   _overlayTitle = message.notification!.title.toString();
//   _overlayBody = message.notification!.body.toString();
//   _overlayImageUrl = message.notification!.android!.imageUrl.toString();*/
//
//   // Launch the overlay
//   overlayMain();
// }
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
//
//   // await PushNotificationService().initNotifications();
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
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//   runApp(const MyApp());
//   // runApp(DevicePreview(
//   //   builder: (context) => const MyApp(),
//   //   enabled: true,
//   // ));
// }
//
// @pragma("vm:entry-point")
// void overlayMain() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CustomOverlay(
//         title: _overlayTitle,
//         body: _overlayBody,
//         imageUrl: _overlayImageUrl,
//         address: _overlayAddress,
//         unit: _overlayUnit,
//         quantity: _overlayQuantity,
//         price: _overlayPrice,
//       ),
//     ),
//   );
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count = 0;

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

      var responseData =
          getNotificationDataFromJson(message.data['details'].toString());
      productList.clear();
      productList.addAll(responseData);
      debugPrint('Product List Notification: ${productList}');


        var imageBytes = await getImageBytes(productList[count].imageName);
        print("Notification Icon " + productList[count].imageName);
        // var imageBytes = await getImageBytes(notification!.android!.imageUrl.toString());
        print("gdxd  " + notification!.android!.imageUrl.toString());

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

        AudioManager.instance.showOverlayWindow();

        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails("0", channel.name,
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

  /*bool _isShowingWindow = false;
  bool _isUpdatedWindow = false;
  SystemWindowPrefMode prefMode = SystemWindowPrefMode.OVERLAY;

  void _showOverlayWindow() async {
    AudioManager.instance.playAlarmTone();
    Timer(Duration(seconds: 30), () {
      AudioManager.instance.stop();
    });
    if (!_isShowingWindow) {
      await SystemAlertWindow.sendMessageToOverlay('show system window');
      SystemAlertWindow.showSystemWindow(
        height: 400,
        width: MediaQuery.of(context).size.width.floor(),
        gravity: SystemWindowGravity.CENTER,
        prefMode: prefMode,
      );
      setState(() {
        _isShowingWindow = true;
      });
    } else if (!_isUpdatedWindow) {
      await SystemAlertWindow.sendMessageToOverlay('update system window');
      SystemAlertWindow.updateSystemWindow(
          height: 400,
          width: MediaQuery.of(context).size.width.floor(),
          gravity: SystemWindowGravity.CENTER,
          prefMode: prefMode,
          isDisableClicks: true);
      setState(() {
        _isUpdatedWindow = true;
        SystemAlertWindow.sendMessageToOverlay(_isUpdatedWindow);
      });
    } else {
      setState(() {
        _isShowingWindow = false;
        _isUpdatedWindow = false;
        SystemAlertWindow.sendMessageToOverlay(_isUpdatedWindow);
      });
      SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
    }
  }*/

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     FirebaseMessaging.instance.requestPermission();
  //     // getNotification();
  //     getnewNotifications();
  //   });
  // }
  //
  // Future<void> getNotification() async {
  //   // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //     RemoteNotification? notification = message.notification;
  //
  //     var imageBytes = await getImageBytes(notification!.android!.imageUrl.toString());
  //
  //     var largeIconBitmap =  ByteArrayAndroidBitmap(imageBytes);
  //
  //     var bigPictureStyleInformation = BigPictureStyleInformation(
  //       largeIconBitmap,
  //       largeIcon: largeIconBitmap,
  //       contentTitle: notification.title,
  //       htmlFormatContentTitle: true,
  //       summaryText: notification.body,
  //       htmlFormatSummaryText: true,
  //     );
  //
  //     flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification!.title,
  //         notification.body,
  //         NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             channel.id,
  //             channel.name,
  //             channelDescription: channel.description,
  //             importance: Importance.max,
  //             largeIcon: largeIconBitmap,
  //             channelShowBadge: true,
  //             playSound: true,
  //             enableVibration: true,
  //             ongoing: true,
  //             styleInformation: bigPictureStyleInformation,
  //             icon: '@drawable/wallpaper',
  //           ),
  //         ));
  //   });
  // }
  //
  // Future<Uint8List> getImageBytes(String imageUrl) async {
  //   var httpClient = HttpClient();
  //   var request = await httpClient.getUrl(Uri.parse(imageUrl));
  //   var response = await request.close();
  //   if (response.statusCode == 200) {
  //     return await consolidateHttpClientResponseBytes(response);
  //   } else {
  //     throw Exception('Failed to load image');
  //   }
  // }
  //
  // Future<void> getnewNotifications() async {
  //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //
  //     if (notification != null && android != null) {
  //       var imageUrl = notification.android!.imageUrl;
  //       if (imageUrl != null) {
  //         var imageBytes = await getImageBytes(imageUrl);
  //         var largeIconBitmap =  ByteArrayAndroidBitmap(imageBytes);
  //
  //         var bigPictureStyleInformation = BigPictureStyleInformation(
  //           largeIconBitmap,
  //           //   DrawableResourceAndroidBitmap(imageUrl),
  //           largeIcon: largeIconBitmap,
  //           contentTitle: notification.title,
  //           htmlFormatContentTitle: true,
  //           summaryText: notification.body,
  //           htmlFormatSummaryText: true,
  //         );
  //
  //         var android = new AndroidNotificationDetails(
  //           channel.id,
  //           channel.name,
  //           channelDescription: channel.description,
  //           importance: Importance.max,
  //           largeIcon: largeIconBitmap,
  //           channelShowBadge: true,
  //           // color: Colors.blue,
  //           playSound: true,
  //           enableVibration: true,
  //           ongoing: true,
  //           priority: Priority.high,
  //           styleInformation: bigPictureStyleInformation,
  //           icon: '@drawable/wallpaper',
  //         );
  //
  //         var platformChannelSpecifics = NotificationDetails(android: android);
  //
  //         _showOverlayWindow();
  //
  //         await flutterLocalNotificationsPlugin.show(
  //           0,
  //           notification.title,
  //           notification.body,
  //           platformChannelSpecifics,
  //         );
  //       } else {}
  //     }
  //   });
  // }
  //
  // Future<void> _showNotification(String? title, String? body) async {
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //       'your_channel_id',
  //       'your_channel_name',
  //       channelDescription: 'your_channel_description',
  //       importance: Importance.max,
  //       priority: Priority.high,
  //       icon: '@drawable/wallpaper'
  //   );
  //   var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics,);
  //
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     title,
  //     body,
  //     platformChannelSpecifics,
  //     payload: 'Default_Sound',
  //   );
  // }
  //
  // bool _isShowingWindow = false;
  // bool _isUpdatedWindow = false;
  // SystemWindowPrefMode prefMode = SystemWindowPrefMode.OVERLAY;
  //
  // void _showOverlayWindow() async {
  //   if (!_isShowingWindow) {
  //     await SystemAlertWindow.sendMessageToOverlay('show system window');
  //     SystemAlertWindow.showSystemWindow(
  //       height: 200,
  //       width: MediaQuery.of(context).size.width.floor(),
  //       gravity: SystemWindowGravity.CENTER,
  //       prefMode: prefMode,
  //     );
  //     setState(() {
  //       _isShowingWindow = true;
  //     });
  //   } else if (!_isUpdatedWindow) {
  //     await SystemAlertWindow.sendMessageToOverlay('update system window');
  //     SystemAlertWindow.updateSystemWindow(
  //         height: 200,
  //         width: MediaQuery.of(context).size.width.floor(),
  //         gravity: SystemWindowGravity.CENTER,
  //         prefMode: prefMode,
  //         isDisableClicks: true);
  //     setState(() {
  //       _isUpdatedWindow = true;
  //       SystemAlertWindow.sendMessageToOverlay(_isUpdatedWindow);
  //     });
  //   } else {
  //     setState(() {
  //       _isShowingWindow = false;
  //       _isUpdatedWindow = false;
  //       SystemAlertWindow.sendMessageToOverlay(_isUpdatedWindow);
  //     });
  //     SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
  //   }
  // }

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
      // home: MyAppss(),
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
