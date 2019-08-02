/*
  File containing all the data and logic pertinent to route displaying the current
  location of the ISS on the map.
*/

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;


// Fetch JSON data from OpenNotify ISS position API
Future<Post> fetchPost() async {
  final response = await http.get('http://api.open-notify.org/iss-now.json');
  
  if (response.statusCode == 200) {
    // Server returns OK response, parse data
    return Post.fromJson(json.decode(response.body));
  } else {
    // Server response not okay, throw error
    throw Exception('Failed to fetch post');
  }
}


// Object containing the nested positon data from the API
class Position {
  final String lat;
  final String long;

  Position({this.lat, this.long});

  // Map iss_position to lat & long using factory constructor
  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      lat: json['latitude'],
      long: json['longitude']
    );
  }

}

// Object containing the data fetched from the API
class Post {
  final int time;
  final String message;
  final Position position;

  Post({this.time, this.message, this.position});

  // Map Json to members using factory constructor
  factory Post.fromJson(Map<String, dynamic> parsedJson) {
    return Post(
      time: parsedJson['timestamp'],
      message: parsedJson['message'],
      position: Position.fromJson(parsedJson['iss_position'])
    );
  }
}

class MapLocation extends StatefulWidget {
  @override
  MapLocationState createState() => MapLocationState();
}

class MapLocationState extends State<MapLocation> {
  GoogleMapController mapController;
  MapType currentMapType = MapType.normal;
  int currentPage;

  var location = new Location();
  Map<String, double> userLocation;

  // Get user location from gps
  Future<Map<String, double>> _getLocation() async {
    var currentLocation = <String, double>{};
    try {
      location.hasPermission();
      currentLocation = await location.getLocation();
    } catch(e) {
      currentLocation = null;
    }
    return currentLocation;
  }


  @override
  void initState() {
    super.initState();

    // Get user location
    _getLocation().then((value) {
      setState(() {
        userLocation = value;
      });
    });
  }


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("ISS Current Location"),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              userLocation['latitude'],
              userLocation['longitude']
            ),
            zoom: 11.0,
          ),
        myLocationEnabled: true,
        mapType: currentMapType,
        
        ),
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Icons.satellite, title: "Location"),
            TabData(iconData: Icons.scatter_plot, title: "2nd Page"),
            TabData(iconData: Icons.schedule, title: "Next Pass"),
            TabData(iconData: Icons.settings, title: "Settings")
          ],
          onTabChangedListener: (position) {
            setState(() {
              currentPage = position;
            });
          },
        )
      )
    );
  }
}
