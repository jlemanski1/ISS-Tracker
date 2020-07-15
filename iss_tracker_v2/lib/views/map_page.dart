import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
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



class LocationMap extends StatefulWidget {
  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  GoogleMapController mapController;
  final Map<String, Marker> _markers = {};
  BitmapDescriptor markerIcon;
  BitmapDescriptor issIcon;
  Future<Post> post;
  Timer _iconTimer;

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


    _svgToBitmapDescriptor(context, 'assets/images/iss.svg').then((value) {
      issIcon = value;
    });
    
    
    // Retrieve Icon for ISS marker
    BitmapDescriptor.fromAssetImage(ImageConfiguration(
      size: Size(128, 128)), 'assets/images/satelliteIconBlue.png').then((onValue) {
        markerIcon = onValue;
      });

    // Update map marker for ISS position every 10 seconds
    _iconTimer = new Timer.periodic(Duration(seconds: 5), (timer) {
      _placeMarkerISSLocation();
    });
  }

  @override
  void dispose() {
    _iconTimer.cancel();
    super.dispose();
  }

  Future<BitmapDescriptor> _svgToBitmapDescriptor(BuildContext context, String assetName) async {
    String svgName = await DefaultAssetBundle.of(context).loadString(assetName);
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgName, null);

    // Calculate Size
    MediaQueryData queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    double width = 32 * devicePixelRatio;
    double height = 32 * devicePixelRatio;

    ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));
    ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    ByteData bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    
    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }


  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    final issLoc = await fetchPost();

    setState(() {
      // Place marker on ISS position
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId(issLoc.time.toString()),
        icon: issIcon,
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
        icon: issIcon,
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
    // Draw loading bar until issPos is fetched
    while (issPos == null) {
      return Center(
        child: CircularProgressIndicator(backgroundColor: Colors.black,),
      );
    }

    // Draw Map once issPos has been fetched for the marker Icon
    return Stack(
      children: <Widget>[
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: issPos,
            zoom: 1.0
          ),
          zoomControlsEnabled: true,
          rotateGesturesEnabled: false,
          scrollGesturesEnabled: false,
          markers: _markers.values.toSet(),
          mapType: MapType.hybrid,
        ),
      ],
    );
  }
}