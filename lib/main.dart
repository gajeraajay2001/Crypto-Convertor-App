import 'package:api_consumer_crypto_converter/screens/android_screen.dart';
import 'package:api_consumer_crypto_converter/screens/ios_screen.dart';
import 'package:flutter/material.dart';

void main() {
  bool switchValue = true;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/": (context) => MyApp(
            switchValue: switchValue,
          ),
      "/android": (context) => AndroidScreen(),
      "/ios": (context) => IosScreen(),
    },
  ));
}

class MyApp extends StatefulWidget {
  bool switchValue;
  MyApp({this.switchValue});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (widget.switchValue == true) ? AndroidScreen() : IosScreen(),
    );
  }
}
