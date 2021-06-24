// @dart=2.9
import 'package:flutter/material.dart';
import 'package:weather_app/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: Colors.white,
          secondary: Colors.blue[900],
        ),
      ),
      // theme: ThemeData.dark().copyWith(
      //   accentColor: Colors.grey,
      // ),
      home: SplashScreen(),
    );
  }
}
