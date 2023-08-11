import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Screens/login_screen.dart';
import 'Screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // new intail
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home:   SplashScreen(),
      // home:   LoginScreen(),
    );
  }
}
