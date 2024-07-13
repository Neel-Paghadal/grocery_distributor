import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/ConstFile/constPreferences.dart';
import 'package:system_alert_window/system_alert_window.dart';

import '../Model/get_notification_model.dart';
import 'dart:async';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../ConstFile/constColor.dart';
import '../ConstFile/constFonts.dart';
import '../Screens/home_screen.dart';

RxList<GetNotificationData> productList = <GetNotificationData>[].obs;
var responseData;

class PushNotificationService {

  // Future<void> initialize() async {
  //
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //     print('Got a message whilst in the foreground!');
  //     print('Message Title: ${message.notification?.title}');
  //     print('Message Body: ${message.notification?.body}');
  //     print('Imageurl: ${message.notification!.android!.imageUrl.toString()}');
  //     print('Message data: ${message.data}');
  //     final responseData = getNotificationDataFromJson(message.data['details'].toString());
  //     homeController.productList.addAll(responseData);
  //     try {
  //       if (message.data.containsKey('userID')) {
  //         String userID = message.data['userID'];
  //         print('$userID userID');
  //
  //       } else {
  //         print('userID key not found in the message data');
  //       }
  //     } catch (e) {
  //       print('Error parsing distributorID: $e');
  //     }
  //
  //     if (message.notification != null) {
  //       print('Message also contained a notification: ${message.notification}');
  //
  //       CustomOverlay();
  //
  //       _showOverlayWindow();
  //     }
  //   });
  //
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print("Background message: $message");
  //     RemoteNotification? notification = message.notification;
  //
  //     if (notification != null) {
  //       CustomOverlay();
  //
  //       _showOverlayWindow();
  //     }
  //
  //     String userID = message.data.toString().split(':')[1].trim().replaceAll('}', '');
  //     print(userID+" userID");
  //   });
  // }

  Future initialize() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message Title: ${message.notification?.title}');
      debugPrint('Message Body: ${message.notification?.body}');
      debugPrint('Message Image: ${message.notification!.android!.imageUrl}');
      debugPrint('Message data: ${message.data}');

      if (message.data.containsKey('details') && message.data['details'] != null && message.data['details'].toString().isNotEmpty) {
        try {
          responseData = getNotificationDataFromJson(message.data['details'].toString());
          productList.clear();
          productList.addAll(responseData);
          if (productList.isNotEmpty) {
            await ConstPreferences().removePreference('productList');
            await ConstPreferences().saveProductList(productList);
            getPreferences();
          }
          debugPrint(productList[0].address.toString());
          // _CustomOverlayState().getPrefrences();
          // getPreferences();
        } catch (e) {
          debugPrint('Error parsing details JSON: $e');
        }
      } else {
        debugPrint('Details not found in message data or is null');
      }

      if (message.notification != null) {
        debugPrint('Message also contained a notification: ${message.notification}');

        // CustomOverlay();
        AudioManager.instance.showOverlayWindow();
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("Background message: $message");
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        // CustomOverlay(responseDatas: responseData,);
        AudioManager.instance.showOverlayWindow();
      }
    });
  }
}

RxList<GetNotificationData> retrievedProductList = <GetNotificationData>[].obs;
int count = 0;


void getPreferences() async {
  count++;
  // String? distributorId = await ConstPreferences().getDistributorId("DistributorId");
  List<GetNotificationData> newProductList = await ConstPreferences().getProductList();
  retrievedProductList.clear();
  // retrievedProductList = await ConstPreferences().getProductList();
  print(newProductList.length);
  retrievedProductList.value = newProductList;
  // retrievedProductList.addAll(newProductList);
  // debugPrint("Distributor Id : -------------- $distributorId");
  debugPrint("Data : -------------- ${retrievedProductList.length}");
  debugPrint("Data : ${retrievedProductList.value}");
  // debugPrint("count : -------------- $count");
}


class CustomOverlay extends StatefulWidget {
   CustomOverlay({super.key});

  @override
  State<CustomOverlay> createState() => _CustomOverlayState();
}

class _CustomOverlayState extends State<CustomOverlay> {
  static const String _mainAppPort = 'MainApp';
  SendPort? mainAppPort;
  bool update = false;
  final Random _random = Random();
  SystemWindowPrefMode prefMode = SystemWindowPrefMode.OVERLAY;
  // final _receivePort = ReceivePort();
  // SendPort? homePort;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    getPreferences();
    // if (homePort != null) return;
    // final res = IsolateNameServer.registerPortWithName(
    //   _receivePort.sendPort,
    //   _mainAppPort,
    // );
    // log("$res: OVERLAY");
    // _receivePort.listen((message) {
    //   log("message from OVERLAY: $message");
    // });
  }

  @override
  void dispose() {
    AudioManager.instance.stop();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    await SystemAlertWindow.requestPermissions(prefMode: prefMode);
  }

  void callBackFunction(String tag) {
    print("Got tag $tag");
    mainAppPort ??= IsolateNameServer.lookupPortByName(_mainAppPort);
    mainAppPort?.send('Date: ${DateTime.now()}');
    mainAppPort?.send(tag);
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    print("getpreference");

    // if (count == 0) {
    //   getPreferences();
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return ListView.builder(
          controller: ScrollController(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: retrievedProductList.length,
          itemBuilder: (context, index) {
            print(retrievedProductList.length.toString() + " edc");
            AudioManager.instance.playAlarmTone();
            Timer(Duration(seconds: 30), () {
              AudioManager.instance.stop();
              SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
            });

            return Card(
                color: Colors.white,
                elevation: 5.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth * 0.01,
                      vertical: deviceHeight * 0.01),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: StickyColors.colors[_random.nextInt(15)],
                            ),
                            height: 55,
                            width: 70,
                            child: CachedNetworkImage(
                              width: deviceWidth * 0.1,
                              imageUrl: retrievedProductList[index].imageName,
                              placeholder: (context, url) => const Icon(Icons.image, size: 45),
                              errorWidget: (context, url, error) => const Icon(Icons.error, size: 40),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: deviceWidth * 0.01),
                                      child: Container(
                                        width: deviceWidth * 0.45,
                                        child: Text(retrievedProductList[index].product,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: ConstFont.popinsRegular,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: deviceHeight * 0.01,
                                          right: deviceHeight * 0.02),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Quantity : ${retrievedProductList[index].quantity}",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              //fontWeight: FontWeight.bold,
                                              fontFamily: ConstFont.popinsRegular,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.only(
                                              left: deviceHeight * 0.005,),
                                            child: Text(retrievedProductList[index].unit,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: ConstFont.popinsRegular,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: deviceWidth * 0.01,
                                      bottom: deviceHeight * 0.01),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                          "assets/Icons/pin.png",
                                          width: deviceWidth * 0.03),
                                      Expanded(
                                        child: Text(
                                          retrievedProductList[index].address,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(letterSpacing: 1.0,
                                              fontSize: 10,
                                              fontFamily: ConstFont.popinsRegular,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*Padding(
                              padding: EdgeInsets.only(
                                  left: deviceWidth * 0.01),
                              child: Text(
                                unit*//* + homeController.removeDecimalValue(homeController.assignOrderList[index].unitType.toString())*//*,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: ConstFont.popinsRegular,
                                    color: Colors.black),
                              ),
                            ),*/
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: deviceWidth * 0.01, bottom: deviceHeight * 0.01),
                                  child: Text(
                                    "₹ ${retrievedProductList[index].price}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: ConstFont.popinsRegular,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
            );
          },
        );
      }),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.005),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff6AB04C)),
                  onPressed: () async {
                    await AudioManager.instance.stop();
                    callBackFunction("Accept");
                    SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
                    // Get.back();
                  },
                  child: const Text(
                    "Accept",
                    style: TextStyle(color: ConstColour.bgColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth * 0.02),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffF86C6B)),
                    onPressed: () async {
                      // Navigator.pop(context);
                      // player.stop();
                      await AudioManager.instance.stop();
                      callBackFunction("Reject");
                      // callBackFunction("Close");
                      SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
                      // Get.back();
                    },
                    child: const Text(
                      "Reject",
                      style: TextStyle(color: ConstColour.bgColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class AudioManager {
  AudioManager._privateConstructor();
  static final AudioManager _instance = AudioManager._privateConstructor();
  static AudioManager get instance => _instance;

  final AudioPlayer audioPlayer = AudioPlayer();

  /*Future<void> playAlarmTone() async {
    await audioPlayer.play(AssetSource('sounds/ringtone.mp3'));
  }*/

  Future<void> playAlarmTone() async {
    try {
      print('Attempting to play alarm tone...');
      await audioPlayer.stop();
      await audioPlayer.play(AssetSource('sounds/ringtone.mp3'));
      print('Audio played successfully');
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  Future<void> stop() async {
    await audioPlayer.stop();
    print('Audio played stop');
  }

  bool _isShowingWindow = false;
  bool _isUpdatedWindow = false;
  SystemWindowPrefMode prefMode = SystemWindowPrefMode.OVERLAY;

  /*void showOverlayWindow() async {
    if (!_isShowingWindow) {
      await SystemAlertWindow.sendMessageToOverlay('show system window');
      SystemAlertWindow.showSystemWindow(
        height: 400,
        width: 400,
        gravity: SystemWindowGravity.CENTER,
        prefMode: prefMode,
      );
      _isShowingWindow = true;
    } else if (!_isUpdatedWindow) {
      await SystemAlertWindow.sendMessageToOverlay('update system window');
      SystemAlertWindow.updateSystemWindow(
          height: 400,
          width: 400,
          gravity: SystemWindowGravity.CENTER,
          prefMode: prefMode,
          isDisableClicks: true);
      _isUpdatedWindow = true;
      SystemAlertWindow.sendMessageToOverlay(_isUpdatedWindow.toString());
    } else {
      _isShowingWindow = false;
      _isUpdatedWindow = false;
      SystemAlertWindow.sendMessageToOverlay(_isUpdatedWindow.toString());
      Timer(Duration(seconds: 30), () {
        AudioManager.instance.stop();
        SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
      });
    }
  }*/

  void showOverlayWindow() async {
    if (!_isShowingWindow) {
      await SystemAlertWindow.sendMessageToOverlay('show system window');
      SystemAlertWindow.showSystemWindow(
        height: 400,
        width: 400,
        gravity: SystemWindowGravity.CENTER,
        prefMode: prefMode,
        isDisableClicks: false);
      _isShowingWindow = true;
    } else {
      _isShowingWindow = false;
      SystemAlertWindow.sendMessageToOverlay(_isShowingWindow.toString());
      // AudioManager.instance.playAlarmTone();
      Timer(Duration(seconds: 30), () {
        AudioManager.instance.stop();
        SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
      });
    }
  }
}

