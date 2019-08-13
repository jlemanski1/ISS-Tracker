/*
  Page displaying some fun facts about the ISS, including the astronauts currently
  onboard.
*/
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


// Fetch json from api
Future<AstroData> _fetchAstros() async {
  final response = await http.get('http://api.open-notify.org/astros.json');

  if (response.statusCode == 200) {
    // Server returns OK response, parse data
    return AstroData.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
      'Unexpected status code ${response.statusCode}: ${response.reasonPhrase}',
      uri: Uri.parse('http://api.open-notify.org/astros.json')
    );
  }
}

// object containing the astronauts info from the data fetched from the api
class AstroData {
  final int count;  // Number of astronauts onboard
  final List<Astronaut> astros;

  AstroData({this.count, this.astros});

  factory AstroData.fromJson(Map<String, dynamic> json) {
    var list = json['people'] as List;
    print(list.runtimeType);
    // Map each object to a new list
    List<Astronaut> astroList = list.map((i) => Astronaut.fromJson(i)).toList();

    return AstroData(
      count: json['number'],
      astros: astroList
    );
  }
}


class Astronaut {
  final String name;
  final String craft;

  Astronaut({this.name, this.craft});

  factory Astronaut.fromJson(Map<String, dynamic> json) {
    return Astronaut(
      name: json['name'],
      craft: json['craft']
    );
  }
}



class ISSInfo extends StatefulWidget {

  @override
  _ISSInfoState createState() => _ISSInfoState();
}


class _ISSInfoState extends State<ISSInfo> {
  
  Future<void> _BuilderAstroTile() async {
    final AstroData astroData = await _fetchAstros();

    return ListView.builder(
      itemCount: astroData.count,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(astroData.astros[index].name),
          subtitle: Text(astroData.astros[index].craft),
        );
      },
    );

  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ISS Info"),
      ),
      body: _BuilderAstroTile()
    );
  }
}