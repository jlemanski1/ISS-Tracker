/*
  File containing all the data and logic pertinent to route displaying the current
  location of the ISS on the map.
*/

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';


// Fetch JSON data from OpenNotify ISS position API
Future<Post> fetchPost() async {
  final response = await http.get('http://api.open-notify.org/iss-now.json');

  if (response.statusCode == 200) {
    // Server returns OK response, parse data
    return Post.fromJson(json.decode(response.body));
  } else {
    // Server response not okay, throw error
    throw HttpException(
      'Unexpected status code ${response.statusCode}:'
      ' ${response.reasonPhrase}',
      uri: Uri.parse('http://api.open-notify.org/iss-now.json'));
  }
}

// Object containing the nested positon data from the API
class Position {
  final String lat; // formerly String
  final String long;

  Position({this.lat, this.long});

  // Map iss_position to lat & long using factory constructor
  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(lat: json['latitude'], long: json['longitude']);
  }
}

// Object containing the data fetched from the API
class Post {
  final int time;
  final String message;
  final Position position;

  Post({this.time, this.message, this.position});

  // Map Json to object members using factory constructor
  factory Post.fromJson(Map<String, dynamic> parsedJson) {
    return Post(
        time: parsedJson['timestamp'],
        message: parsedJson['message'],
        position: Position.fromJson(parsedJson['iss_position']));
  }
}


class MapLocation extends StatefulWidget {
  @override
  MapLocationState createState() => MapLocationState();
}

class MapLocationState extends State<MapLocation> {
  GoogleMapController mapController;
  int currentPage;

  Future<Post> post;

  var location = new Location();
  Map<String, double> userLocation;
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final iss_loc = await fetchPost();
    
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId(iss_loc.time.toString()),
        position: LatLng(double.parse(iss_loc.position.lat), double.parse(iss_loc.position.long)),
        infoWindow: InfoWindow(
          title: 'Current ISS Location',
          snippet: "${iss_loc.time}\n${iss_loc.position.lat}/${iss_loc.position.long}"
        ),
      );
      _markers[iss_loc.time.toString()] = marker;
    });
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

    // Get ISS location
    post = fetchPost();

    // Get user location
    _getLocation().then((value) {
      setState(() {
        userLocation = value;
      });
    });
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
                target:
                    LatLng(userLocation['latitude'], userLocation['longitude']),
                zoom: 11.0,
              ),
              markers: _markers.values.toSet(),
              myLocationEnabled: true,
              mapType: MapType.hybrid,
            ),
            
            /*
        FutureBuilder<Post>(
          future: post,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var issLoc = LatLng(snapshot.data.position.lat, snapshot.data.position.long)
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          }
        ),
        */
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
            )));
  }
}
