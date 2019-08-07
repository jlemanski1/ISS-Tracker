/*
  Page displaying some fun facts about the ISS, including the astronauts currently
  onboard.
*/
import 'package:flutter/material.dart';

class ISSInfo extends StatefulWidget {

  @override
  _ISSInfoState createState() => _ISSInfoState();
}

class _ISSInfoState extends State<ISSInfo> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ISS Info"),
      ),
      body: Center(
        child: Text("Nothing here yet")),
    );
  }
}