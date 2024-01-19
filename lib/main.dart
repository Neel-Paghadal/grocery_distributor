import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'Screens/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
