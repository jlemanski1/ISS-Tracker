import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

import 'locmap.dart';
import 'issInfo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISS Tracker',
      theme: ThemeData.dark(),
      home: MapLocation(),
      
    //TODO: refactor _getPage into here to make LocationMap just like the other pages in the switch
    // Make each appbar part of each page so they can all have their own name
      
    );
  }
}
