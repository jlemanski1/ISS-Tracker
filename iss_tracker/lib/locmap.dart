/*
  File containing all the data and logic pertinent to route displaying the current
  location of the ISS on the map.
*/

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iss_tracker/issInfo.dart';
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
    throw HttpException(
      'Unexpected status code ${response.statusCode}:'
      ' ${response.reasonPhrase}',
      uri: Uri.parse('http://api.open-notify.org/iss-now.json'));
  }
}

// Object containing the nested positon data from the API
class Position {
  final String lat;
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
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  Future<Post> post;  // ISS Json data

  var iss_pos;
  var location = new Location();
  Map<String, double> userLocation = {};
  final Map<String, Marker> _markers = {};
  
  // Get ISS position, and place a marker on the map
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final iss_loc = await fetchPost();
    
    //TODO: Make lil ISS icon to replace the std marker icon
    
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId(iss_loc.time.toString()),
        position: LatLng(double.parse(iss_loc.position.lat), double.parse(iss_loc.position.long)),
        infoWindow: InfoWindow(
          title: 'Current ISS Location',
          snippet: "Lat:${iss_loc.position.lat} Long:${iss_loc.position.long}"
        ),
      );
      _markers[iss_loc.time.toString()] = marker;
    });
  }

  // Updates the marker with the ISS' current location
  Future<void> _placeMarkerISSLocation() async {
    final iss_loc = await fetchPost();

    //TODO: Make lil ISS icon to replace the std marker icon
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId(iss_loc.time.toString()),
        position: LatLng(double.parse(iss_loc.position.lat), double.parse(iss_loc.position.long)),
        infoWindow: InfoWindow(
          title: 'Current ISS Location',
          snippet: "Lat:${iss_loc.position.lat} Long:${iss_loc.position.long}"
        ),
      );
      _markers[iss_loc.time.toString()] = marker;
    });
  }

  // Fetch iss data and return the position obj
  Future<void> _getISSLocation() async {
    var iss_pos = await fetchPost();
    if (iss_pos.message == 'success') {
      print('ISS_POS: ${iss_pos.position}');
      return iss_pos;
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

  // Animates the camera to the marker(the ISS' latest received position)
  Future<void> _goToISS() async {
    var _iss_pos = await fetchPost();
    
    if (_iss_pos.message == 'success') {
      double lat = double.parse(_iss_pos.position.lat);
      double long = double.parse(_iss_pos.position.long);
      
      GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
    }
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

    iss_pos = _getISSLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(child: CircularProgressIndicator(),),  //Render CircularProgIndicator until map loads
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: (userLocation['latitude'] == null)//LatLng(double.parse(iss_pos.position.lat), double.parse(iss_pos.position.long)),
                ? LatLng(0, 0)
                : LatLng(userLocation['latitude'], userLocation['longitude']),
            zoom: 1.0,
          ),
          zoomGesturesEnabled: true,
          rotateGesturesEnabled: true,
          markers: _markers.values.toSet(),
          //myLocationEnabled: true,  // Replace with floating action button
          mapType: MapType.normal, 
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.symmetric(vertical: 16.0)),
                  FloatingActionButton(
                    onPressed: _placeMarkerISSLocation,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.black26,
                    child: const Icon(Icons.add_location, size : 36.0),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 16.0)),
                  FloatingActionButton(
                    onPressed: (){},  // Replace (){} with function
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.black26,
                    child: const Icon(Icons.map, size: 36.0),
                  )
                ],
              ),
            ),
          )
        ],
      );
  }
}
