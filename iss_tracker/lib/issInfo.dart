/*
  Page displaying some fun facts about the ISS, including the astronauts currently
  onboard.
*/
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



Future<Post> _fetchPost() async {
  final response = await http.get('http://api.open-notify.org/astros.json');

  if (response.statusCode == 200) {
    // Server returns OK response, parse data
    return Post.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
      'Unexpected status code ${response.statusCode}: ${response.reasonPhrase}',
      uri: Uri.parse('http://api.open-notify.org/astros.json')
    );
  }
}

// object containing the astronaughts (onboard) data fetched from the api
class Post {
  final Astronaut astronaut;  // The object containing the name data
  final int count;  // How many are onboard

  Post({this.astronaut, this.count});

  // Maps json data to object members
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      astronaut: Astronaut.fromJson(json['people']),
      count: json['number']
    );
  }
}


// Parsing needs fixing, json goes  people:[{name, craft},{name,craft},...]
class Astronaut {
  final String name;  // The astronaut's name
  final String craft; // The Craft they're aboard

  Astronaut({this.name, this.craft});
  
  // Maps json data to object members
  factory Astronaut.fromJson(Map<String, dynamic> parsedJson) {
    return Astronaut(
      name: parsedJson['name'],
      craft: parsedJson['craft']
    );
  }
}



class ISSInfo extends StatefulWidget {

  @override
  _ISSInfoState createState() => _ISSInfoState();
}

class _ISSInfoState extends State<ISSInfo> {

  Future<void> _getAstroData() async {
    final astroData = await _fetchPost();

    final names = Text(
      '''There are currently ${astroData.count} astronauts onboard the ${astroData.astronaut.craft},
      they are ${astroData.astronaut.name}
      ''');

      return names;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ISS Info"),
      ),
      body: Center(
        child: Text(_getAstroData().toString())),
    );
  }
}