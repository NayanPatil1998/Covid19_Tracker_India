import 'package:covid19_tracker/Screens/Home/home.dart';
import 'package:covid19_tracker/utils/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19 tracker',
      theme: ThemeData(
        fontFamily: "Poppins",
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: TextTheme(body1: TextStyle(color: kBodyTextColor)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
