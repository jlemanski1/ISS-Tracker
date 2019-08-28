/*
  Page displaying the next pass date & times for the user's location
  Given a location on Earth (latitude, longitude, and altitude) the API will compute the next n number
  of times that the ISS will be overhead.
*/
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;


// Fetch Next Pass Time data from OpenNotify
Future<Pass> fetchNextPasses() async {
  final response = await http.get('http://api.open-notify.org/iss-pass.json?lat=53.5461&lon=113.4938&alt=635');
  //('http://api.open-notify.org/iss-pass.json?lat=${USERLAT}&lon=${USERLONG}')

  if (response.statusCode == 200) {
    // Server returns OK response, parse data
    //print(Pass.fromJson(json.decode(response.body)));
    return Pass.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
      'Unexpected status code ${response.statusCode}: ${response.reasonPhrase}',
      uri: Uri.parse('http://api.open-notify.org/iss-pass.json?lat=53.5461&lon=113.4938&alt=635') //Yeg coords
    );
  }
}



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

  factory PassTime.fromJson(Map<String, dynamic> json) {
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
  var _nextPasses;
  var location = new Location();
  Map<String, double> userLocation;
  double userLat, userLong, userAlt;


  // Fetches the data from the api and returns only the list of next passes
  Future<List> _getNextPasses() async {
    var passList = await fetchNextPasses();
    if (passList.message == 'success') {
      return passList.passes;
    }
  }

  // Get user location from gps
  Future<Map<String, double>> _getLocation() async {
    var currentLocation = <String, double>{};
    try {
      location.hasPermission();
      currentLocation = await location.getLocation();
      
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }



  @override
  void initState() {
    super.initState();

    // Get User Coords
    _getLocation().then((value) {
      setState(() {
        userLocation = value;
      });
    });

    // Get Next 5 Passtimes
    //_nextPasses = _getNextPasses();
    _getNextPasses().then((val) {
      setState(() {
        _nextPasses = val;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Next Pass Date & Time"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('The ISS will pass over your current location on:',
              style: TextStyle(fontWeight: FontWeight.bold)
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: _nextPasses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      color: Colors.blueGrey,
                      child: Text(
                        'Duration: ${_nextPasses.elementAt(index).duration}\nRiseTime: ${_nextPasses.elementAt(index).risetime}'
                        ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}