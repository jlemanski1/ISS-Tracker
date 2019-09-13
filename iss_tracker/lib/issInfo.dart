/*
  Page displaying some fun facts about the ISS, including the astronauts currently
  onboard.
*/
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


// Fetch json from OpenNotify
Future<AstroData> fetchAstros() async {
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
    
    // Map each object to a new list
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
  List<Astronaut> _astroList;  // List of astronauts


  Future<List> astroListBuilder() async {
    var astroList = await fetchAstros();

    return astroList.astros;
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
    
    return Scaffold(
      appBar: AppBar(
        title: Text("ISS Info"),
      ),
      body: Container(
        padding: new EdgeInsets.symmetric(vertical: 16.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              Column (
                children: <Widget>[
                  
                  Text(
                    "Information about the International Space Station",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  /*
                  Center(
                    child: 
                      Image.asset("assets/images/ISS.png", fit: BoxFit.fill)
                  )
                  */
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.info),
                          title: Text('PlaceHolder Title'),
                          subtitle: Text(
                            'PlaceHolder Text'
                          ),
                        ),
                      ],
                    ),
                  ),
                    
                ]
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0),
              ),
              // Info from API below
              Text (
                "There are currently ${_astroList.length} astronauts in space. They are:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded (
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: _astroList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.nature),
                            title: Text('Name: ${_astroList.elementAt(index).name}'),
                            subtitle: Text('Craft: ${_astroList.elementAt(index).craft}'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}