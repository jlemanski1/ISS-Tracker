import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
    
    return NeumorphicApp(
      title: 'ISS Tracker',
      debugShowCheckedModeBanner: false,
      theme: NeumorphicThemeData(
        lightSource: LightSource.topLeft,
        baseColor: Colors.white,
        accentColor: Colors.blue,
        depth: 10,
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Colors.black,
        lightSource: LightSource.topLeft,
        depth: 6,
        intensity: 0.5,
      ),
      home: NavigationHomeScreen(),
    );
  }
}
