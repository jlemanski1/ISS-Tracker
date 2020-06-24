import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:http/http.dart' as http;


/*
  Page displaying the next pass date & times for the user's location
  Given a location on Earth (latitude, longitude, and altitude) the API will compute the next n number
  of times that the ISS will be overhead.
*/


// Fetch Next Pass Time data from OpenNotify
Future<Pass> fetchNextPasses(double lat, double long, double alt) async {
  // Get data for user location
  final response = await http.get('http://api.open-notify.org/iss-pass.json?lat=$lat&lon=$long&alt=$alt');
  if (response.statusCode == 200) {
    // Server returns OK response, parse data
    return Pass.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
      'Unexpected status code ${response.statusCode}: ${response.reasonPhrase}',
      uri: Uri.parse('http://api.open-notify.org/iss-pass.json?lat=$lat&lon=$long&alt=$alt')
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


class NextPassTimes extends StatefulWidget {
  @override
  _NextPassTimesState createState() => _NextPassTimesState();
}

class _NextPassTimesState extends State<NextPassTimes> {
  List _nextPasses = [];
  Location location = new Location();
  PermissionStatus _permissionGranted;
  bool _serviceEnabled;

  BeautifulPopup popup1, popup2, popup3;


  // Enables location services and requests user permission
  void getLocationPermissions() async {
    // Enable location services
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled)
        return;
    }

    // Request Permissions
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted)
        return;
    }
  }

  // Fetches the data from the api and returns only the list of next passes
  Future<List> _getNextPasses() async {
    var userLoc = await location.getLocation();
    var passList = await fetchNextPasses(userLoc.latitude, userLoc.longitude, userLoc.altitude);
    
    if (passList.message == 'success') {
      return passList.passes;
    } else {
      return [];
    }
  }


  @override
  void initState() {
    super.initState();

    getLocationPermissions();

    // Get Next 5 Passtimes
    _getNextPasses().then((val) {
      setState(() {
        _nextPasses = val;
      });
    });

    popup1 = BeautifulPopup(
      context: context,
      template: TemplateBlueRocket
    );
    popup2 = BeautifulPopup(
      context: context,
      template: TemplateGreenRocket
    );
    popup3 = BeautifulPopup(
      context: context,
      template: TemplateOrangeRocket
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        centerTitle: true,
        title: Text("Overhead Pass Times",
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
            colors: [Colors.blueGrey[400], Colors.cyan[400]]
          ),
        ),
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
                      popup1.show(
                        title: 'Spot the ISS!',
                        content: "The space station looks like an airplane or a very bright star moving across the sky, except it "
                          +"doesn’t have flashing lights or change direction. It will also be moving considerably faster than a typical "
                          +"airplane (airplanes generally fly at about 965 Km/h); the space station flies at 28,000 Km/h.",
                        actions: [
                          popup1.button(
                            label: 'Close',
                            onPressed: Navigator.of(context).pop,
                          ),
                        ],
                      );
                    }
                  ),
                  IconButton(
                    icon: Icon(Icons.insert_chart),
                    onPressed: () {
                      popup2.show(
                        title: 'Where do I look?',
                        content: "Overhead is 10 degrees in elevation for the observer. If you look up at the given time"
                          +", you'll be able to see the craft soar across the sky. It will looking similar to a shooting star."
                          +" You'll only have the given time to spot it before it will disappear beyond the horizon.",
                        actions: [
                          popup2.button(
                            label: 'Close',
                            onPressed: Navigator.of(context).pop,
                          ),
                        ],
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.local_airport),
                    onPressed: () {
                      popup3.show(
                        title: 'Caution',
                        content: "The time are less accurate for later times as the orbit of the ISS decays unpredictably over time."
                          +"Station controllers will also periodically move the craft to higher and lower orbits for docking, "
                          +"re-boost, and debris avoidance. The green hour indicator let's you know that this time will be more accutrate.",
                        actions: [
                          popup3.button(
                            label: 'Close',
                            onPressed: Navigator.of(context).pop,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
              Text('The ISS will pass over your current location on:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.blueGrey[900],
                ),
              ),
              Expanded(
                // Show loading circle until list loads then build tiles
                child: _nextPasses.length == 0 ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                  )
                ) :
                ListView.builder(
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