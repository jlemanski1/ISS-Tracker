/*
  File containing all the data and logic pertinent to route displaying the current
  location of the ISS on the map.
*/

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  
  GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  Future<Post> post;  // ISS Json data
  BitmapDescriptor markerIcon;

  LatLng issMapPos;
  LatLng issPos;

  // Get's the user and ISS' coords, and the custom marker Icon
  @override
  void initState() {
    super.initState();
    
    // Get ISS position for map camera target
    _getISSLocation().then((value) {
      setState(() {
        issPos = value;
      });
    });
    
    // Retrieve Icon for ISS marker
    BitmapDescriptor.fromAssetImage( ImageConfiguration(
      size: Size(64, 64)), 'assets/satelliteIcon.png').then((onValue) {
        markerIcon = onValue;
      });

    // Update map marker for ISS position every 10 seconds
    Timer.periodic(Duration(seconds: 10), (timer) {
      _placeMarkerISSLocation();
    });
  }

  
  // Get ISS position, and place a marker on the map
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final issLoc = await fetchPost();

    setState(() {
      // Place marker on ISS position
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId(issLoc.time.toString()),
        icon: markerIcon,
        position: LatLng(double.parse(issLoc.position.lat), double.parse(issLoc.position.long)),
        infoWindow: InfoWindow(
          title: 'Current ISS Location',
          snippet: "Lat:${issLoc.position.lat} Long:${issLoc.position.long}"
        ),
      );
      _markers[issLoc.time.toString()] = marker;
    });
  }
  

  // Updates the marker with the ISS' current location
  Future<void> _placeMarkerISSLocation() async {
    final issLoc = await fetchPost();

    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId(issLoc.time.toString()),
        icon: markerIcon,
        position: LatLng(double.parse(issLoc.position.lat), double.parse(issLoc.position.long)),
        infoWindow: InfoWindow(
          title: 'Current ISS Location',
          snippet: "Lat:${issLoc.position.lat} Long:${issLoc.position.long}"
        ),
      );
      _markers[issLoc.time.toString()] = marker;
    });
  }


  // Fetches and assigns the ISS' location to issPos
  Future<LatLng> _getISSLocation() async {
    var iPos = await fetchPost();
    var pos = LatLng(double.parse(iPos.position.lat), double.parse(iPos.position.long));
    return pos;
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(child: SpinKitWave(color: Colors.amberAccent, type: SpinKitWaveType.start,)),
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: issPos,
            zoom: 1.0,
          ),
          zoomGesturesEnabled: true,
          rotateGesturesEnabled: true,
          markers: _markers.values.toSet(),
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
                    onPressed: () {
                      
                    },
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
