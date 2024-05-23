import 'package:kadpilgrims/screens/auth/authscree.dart';
import 'package:kadpilgrims/screens/onboardingscreen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(221, 225, 249, 1),
        primaryColor: const Color.fromRGBO(94, 80, 201, 1),
      ),
      // home: Onbradingscreens(),
      home:  MyLogin(),
    );
  }
}
