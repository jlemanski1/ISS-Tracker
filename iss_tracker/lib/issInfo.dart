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
    //print(AstroData.fromJson(json.decode(response.body)));
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
    print("Astro list: ${list}");
    
    // Map each object to a new list
    //TODO ISSUE possibly around here
    List<Astronaut> astroList = list.map((i) => Astronaut.fromJson(i)).toList();

    return AstroData(
      count: json['number'],
      astros: astroList
      //astroList
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
  List _astroList;


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

  Future<List> astroListBuilder() async {
    var astroList = await _fetchAstros();

    print(astroList.astros[0].name);
    return astroList.astros;
    
    /*return Container(
      padding: EdgeInsets.all(32.0),
      child: Center (
        child: Column(
          children: <Widget>[
            Text("Astronauts Currently in Space"),
            Text(astroList.astros[0].name),
            Text(astroList.astros[0].craft),
          ],
        )
      )
    );
    */
  }
  
  @override
  void initState() {
    super.initState();

  astroListBuilder().then((value) {
    setState(() {
     _astroList = value; 
    });
  });
    
  }


  @override
  Widget build(BuildContext context) {
    //var astroListo = astroListBuilder();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("ISS Info"),
      ),
      body: //astroListBuilder();
        
        new Container(
          padding: new EdgeInsets.all(32.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                Text("Astronauts in Space", style: TextStyle(fontWeight: FontWeight.bold),),
                Text("${_astroList[0].name} is onboard the ${_astroList[0].craft}"),
              ],
            )
          ),
        )
    );
  }
}