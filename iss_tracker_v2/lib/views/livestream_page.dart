import 'package:flutter/material.dart';
import 'package:iss_tracker_v2/components/settings.dart';

class LivestreamPage extends StatefulWidget {
  @override
  _LivestreamPageState createState() => _LivestreamPageState();
}

class _LivestreamPageState extends State<LivestreamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Settings.isLightTheme ? Colors.blueGrey[400] : Colors.black54,
        centerTitle: true,
        title: Text("Earth Live View",
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
      child: Center(
        child: Text(
          'Page under construction',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Settings.isLightTheme ? Colors.black : Colors.white
          )
        )),
      ),
    );
  }
}