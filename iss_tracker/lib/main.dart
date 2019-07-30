import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
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


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISS Tracker',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        accentColor: Colors.amberAccent
      ),
      home: MyHomePage(title: 'ISS Current Location'),
    );
  }
}


/*
    HOMEPAGE (Current ISS location)
*/
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


/*
    HOMEPAGE STATE (Current ISS location)
*/
class _MyHomePageState extends State<MyHomePage> {
  Future<Post> post;

  // Fetch data when state is initialized. Called once and only once (TODO: Fetch every 5 sec while screen active)
  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        
      ),
      body: Center(
        child: FutureBuilder<Post>(
          future: post,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                "Time: ${snapshot.data.time}\nPos: (lat/long): (${snapshot.data.position.lat}/${snapshot.data.position.long})"
                );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // Default, show loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.hotel),
            title: new Text('2nd Page'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.motorcycle),
            title: new Text('3rd Page'),
          )
        ],
      ),
    );
  }
}
