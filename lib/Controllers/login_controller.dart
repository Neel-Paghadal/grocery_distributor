import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Common/utils.dart';
import '../ConstFile/constPreferences.dart';

class LoginController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  RxBool isLoading = false.obs;

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  var fcmToken = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initializeFCM();
  }

  Future<void> initializeFCM() async {
    await generateToken();
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
        await ConstPreferences().setFcmToken(newToken);
        fcmToken.value = newToken;
        print('Refreshed FCM Token: $newToken');
    });
  }

  Future<void> generateToken() async {
    await refreshToken();
    print("Refresh Token");
    await _fcm.requestPermission();
    final fCMToken = await _fcm.getToken();
    print('FCM Token: $fCMToken');
    if (fCMToken != null && fCMToken.isNotEmpty) {
      await ConstPreferences().setFcmToken(fCMToken);
      fcmToken.value = fCMToken;
    }
  }

  Future<void> refreshToken() async {
    await _fcm.deleteToken();
  }

  /*Future<void> generateToken() async {
    print("refresh Token");
    await _fcm.requestPermission();
    final fCMToken = await _fcm.getToken();
    debugPrint('FCM Token $fCMToken');
    if (fCMToken!.isNotEmpty) {
      ConstPreferences().setFcmToken(fCMToken);
    }
    // initialize();
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }*/

}