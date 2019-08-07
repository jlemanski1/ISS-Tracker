/*
  Page displaying the next pass date & times for the user's location
*/
import 'package:flutter/material.dart';

class NextPass extends StatefulWidget {

  @override
  _NextPassState createState() => _NextPassState();
}

class _NextPassState extends State<NextPass> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Next Pass Date & Time"),
      ),
      body: Center(
        child: Text("Nothing here yet either")),
    );
  }
}