import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

import 'locmap.dart';
import 'issInfo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  int currentPage;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISS Tracker',
      theme: ThemeData.dark(),
      home: MapLocation(),
      

      
    );
  }
}
