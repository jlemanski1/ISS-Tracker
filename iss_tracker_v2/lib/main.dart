import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iss_tracker_v2/views/nav_home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Hide System Status Bar & Icons
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    ));
    
    return MaterialApp(
      title: 'ISS Tracker',
      debugShowCheckedModeBanner: false,
      home: NavigationHomeScreen(),
    );
  }
}
