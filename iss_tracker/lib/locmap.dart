/*
  File containing all the data and logic pertinent to route displaying the current
  location of the ISS on the map.
*/

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLocation extends StatefulWidget {
  @override
  MapLocationState createState() => MapLocationState();
}

class MapLocationState extends State<MapLocation> {
  GoogleMapController mapController;

  //tmp: get latlng from ISS data
  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ISS Current Location"),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      )
    );
  }
}
