/*
  Page displaying the next pass date & times for the user's location
  Given a location on Earth (latitude, longitude, and altitude) the API will compute the next n number
  of times that the ISS will be overhead.
*/
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


// Pass data containing error message and next 5 passes
class Pass {
  final String message;
  final List<PassTime> passes;

  Pass({this.message, this.passes});

  factory Pass.fromJson(Map<String, dynamic> json) {
    var list = json['response'] as List;
    List<PassTime> passList = list.map((i) => PassTime.fromJson(i)).toList();
    return Pass(
      message: json['message'],
      passes: passList
    );
  }
}

// Duration and Time of the next pass
class PassTime {
  final int duration;
  final int risetime;

  PassTime({this.duration, this.risetime});

  factory PassTime.fromJson(Map<String, int> json) {
    return PassTime(
      duration: json['duration'],
      risetime: json['risetime']
    );
  }
}



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