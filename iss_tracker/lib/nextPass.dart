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
Future<Pass> fetchNextPasses(double lat, double long, double alt) async {
  final response = await http.get('http://api.open-notify.org/iss-pass.json?lat=$lat&lon=$long&alt=$alt');
  if (response.statusCode == 200) {
    // Server returns OK response, parse data
    //print(Pass.fromJson(json.decode(response.body)));
    return Pass.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
      'Unexpected status code ${response.statusCode}: ${response.reasonPhrase}',
      uri: Uri.parse('http://api.open-notify.org/iss-pass.json?lat=$lat&lon=$long&alt=$alt') //Yeg coords
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
  List _nextPasses = [];
  var location = new Location();
  Map<String, double> userLocation;
  double userLat, userLong, userAlt;

  // Fetches the data from the api and returns only the list of next passes
  Future<List> _getNextPasses() async {
    _getLocation(); // userLocation required for pass time calc
    var passList = await fetchNextPasses(userLat, userLong, userAlt);
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
        userLat = userLocation['latitude'];
        userLong = userLocation['longitude'];
        userAlt = userLocation['altitude'];
      });
      
    });

    // Get Next 5 Passtimes
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
        title: Text("Overhead Pass Times", style: TextStyle(color: Colors.lightBlueAccent),),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      showDialog(context: context, builder: (builder) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.0)
                          ),
                          elevation: 0.0,
                          backgroundColor: Colors.white54,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Card(
                                child: ListTile(
                                  leading: Icon(Icons.info_outline),
                                  title: Text('Spot the ISS!', style: TextStyle(color: Colors.lightBlueAccent),),
                                  subtitle: Text("The ISS is moving ~28000km/h so its location changes really fast! In 24 hours, the station makes"
                                    +" 16 orbits of Earth, traveling through 16 sunrises and sunsets. This page will compute the next n number of times"
                                    +" that the ISS is overhead."),
                                ),
                              ),
                              Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                              Card(
                                child: ListTile(
                                  leading: Icon(Icons.info_outline),
                                  title: Text('Where do I look?', style: TextStyle(color: Colors.lightBlueAccent),),
                                  subtitle: Text("Overhead is defined as 10 degrees in elevation for the observer. If you look up at the given time"
                                    +", you'll be able to see the craft soar across the sky. It will looking similar to a shooting star. Be quick"
                                    +" though! You'll only have the given time to spot it before it will disappear beyond the horizon."),
                                ),
                              ),
                              Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                              Card(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const ListTile(
                                      leading: Icon(Icons.info_outline),
                                      title: Text('Caution', style: TextStyle(color: Colors.lightBlueAccent),),
                                      subtitle: Text(
                                        "The time are less accurate for later times as the orbit of the ISS decays unpredictably over time."
                                        +"Station controllers will also periodically move the craft to higher and lower orbits for docking, "
                                        +"re-boost, and debris avoidance. The green hour indicator let's you know that this time will be more accutrate."
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                    }
                  ),
                  // Random icons since I might add more stuff here (Splits the page nicely)
                  IconButton(
                    icon: Icon(Icons.insert_chart),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.local_airport),
                    onPressed: () {},
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
              Text('The ISS will pass over your current location on:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlueAccent)
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: _nextPasses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Text(
                              '${(new DateTime.fromMillisecondsSinceEpoch(_nextPasses.elementAt(index).risetime * 1000).hour)}',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.accents[index + 10]), // Closest appear green (green = good)
                              textAlign: TextAlign.center,
                              ),
                            title: Text(
                              'Starting: ${new DateTime.fromMillisecondsSinceEpoch(_nextPasses.elementAt(index).risetime * 1000)}'
                              +' ${DateTime.fromMillisecondsSinceEpoch(_nextPasses.elementAt(index).risetime * 1000).timeZoneName}'
                              ),
                            subtitle: Text(
                              'Visible for ${_nextPasses.elementAt(index).duration} seconds'
                            ),
                          ),
                        ],
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