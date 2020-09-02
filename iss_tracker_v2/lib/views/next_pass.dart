import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:iss_tracker_v2/components/settings.dart';
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

  Row _nextPassInfoButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info,
          color: Settings.isLightTheme ? Colors.black : Colors.blueGrey[300],
        ),
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
          icon: Icon(
            Icons.insert_chart,
            color: Settings.isLightTheme ? Colors.black : Colors.blueGrey[300],
          ),
          onPressed: () {
            popup2.show(
              title: 'Where do I look?',
              content: "The space station is visible because it reflects the light of the Sun, just as the moon does. It's "
                +"not bright enough to see during the day; It can only be spotted at dawn or dusk. You can spot it with your "
                +"bare eyes, no special equipment required!",
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
          icon: Icon(
            Icons.local_airport,
            color: Settings.isLightTheme ? Colors.black : Colors.blueGrey[300],  
          ),
          onPressed: () {
            popup3.show(
              title: 'Caution',
              content: "The times are less accurate for later times as the orbit of the ISS decays unpredictably over time. "
                +"Station controllers will also periodically move the craft to higher and lower orbits for docking, "
                +"re-boost, and debris avoidance. The soonest times will be most accurate.",
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
    );
  }

  @override
  void initState() {
    super.initState();

    Settings.getLightMode();
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
      body: Container(
        color: Settings.isLightTheme ? Colors.white : Color(0xFF121212),
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              ClayContainer(
                depth: 50,
                color: Settings.isLightTheme ? Colors.white : Color(0xFF393b44),
                emboss: Settings.isLightTheme ? false : true,
                height: 150,
                width: MediaQuery.of(context).size.width,
                customBorderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 45),),
                    Text(
                      'Overhead Pass Times',
                      style: TextStyle(
                        color: Settings.isLightTheme ? Colors.black : Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'WorkSans',
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 20)),
                    _nextPassInfoButtons(),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30),),
              Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
              Text('The ISS will pass over your current location on:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Settings.isLightTheme ? Colors.blueGrey[900] : Colors.blueGrey[100],
                ),
              ),
              Expanded(
                // Show loading circle until list loads then build tiles
                child: _nextPasses.length == 0 ? Center(
                  child: ClayContainer(
                    color: Settings.isLightTheme ? Colors.white : Color(0xFF393b44),
                    emboss: true,
                    height: 75,
                    width: 75,
                    borderRadius: 50,
                    depth: 40,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    ),
                  )
                ) :
                ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: _nextPasses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClayContainer(
                            depth: 40,
                            borderRadius: 10,
                            color: Settings.isLightTheme ? Colors.white : Color(0xFF121212),
                            emboss: index % 2 == 1 ? false : true,
                            child: ListTile(
                              leading: Text(
                                '${(new DateTime.fromMillisecondsSinceEpoch(_nextPasses.elementAt(index).risetime * 1000).hour)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.accents[index + 10]), // Closest appear green (green = good)
                                  textAlign: TextAlign.center,
                                ),
                              title: Text(
                                'Starting: ${new DateTime.fromMillisecondsSinceEpoch(_nextPasses.elementAt(index).risetime * 1000).toString().substring(0, DateTime.fromMillisecondsSinceEpoch(_nextPasses.elementAt(index).risetime).toString().length - 4)}'
                                +' ${DateTime.fromMillisecondsSinceEpoch(_nextPasses.elementAt(index).risetime * 1000).timeZoneName}',
                                style: TextStyle(
                                  color: Settings.isLightTheme ? Colors.black : Colors.blueGrey[200],
                                ),
                                ),
                              subtitle: Text(
                                'Visible for ${_nextPasses.elementAt(index).duration} seconds',
                                style: TextStyle(
                                  color: Settings.isLightTheme ? Colors.black : Colors.blueGrey[400],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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