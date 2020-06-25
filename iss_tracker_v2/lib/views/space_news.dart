import 'package:flutter/material.dart';
import 'package:iss_tracker_v2/components/settings.dart';

class SpaceNews extends StatefulWidget {
  @override
  _SpaceNewsState createState() => _SpaceNewsState();
}

class _SpaceNewsState extends State<SpaceNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Settings.isLightTheme ? Colors.blueGrey[400] : Colors.black54,
        centerTitle: true,
        title: Text("Space News",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'WorkSans',
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: Settings.isLightTheme ? [Colors.blueGrey[400], Colors.pink[200]]
              : [Colors.black87, Colors.black],
          )
        ),
      
      ),
    );
  }
}