/*
  Page displaying some fun facts about the ISS, including the astronauts currently
  onboard.
*/
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'spaceFacts.dart';

/* More info
International Space Station Size & Mass

    Pressurized Module Length: 167.3 feet (73 meters)
    Truss Length: 357.5 feet (109 meters)
    Solar Array Length: 239.4 feet (73 meters)
    Mass: 925,335 pounds (419,725 kilograms)
    Habitable Volume: 13,696 cubic feet (388 cubic meters) not including visiting vehicles
    Pressurized Volume: 32,333 cubic feet (916 cubic meters)
    With BEAM expanded: 32,898 cubic feet (932 cubic meters)
    Power Generation: 8 solar arrays provide 75 to 90 kilowatts of power
    Lines of Computer Code: approximately 2.3 million
*/



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
  
  List<Astronaut> _astroList = [];  // List of astronauts
  Facts facts = new Facts();        // Facts Object pulled from json file
  List<String> factList;  // List of String facts
  String randomFact;      // Random Fact from the file

  Future<Facts> factFetcher() async {
    var _facts = fetchFacts();
    print('test:\n');
    return _facts;
  }

  Future<List> astroListBuilder() async {
    var astroList = await fetchAstros();
    return astroList.astros;
  }
  
  @override
  void initState() {
    super.initState();

    facts.facts = ['']; // Initilizae to empty string, prevent fetching when null

    factFetcher().then((value) {
      setState(() {
        facts = value;
      });
    });
    
    astroListBuilder().then((value) {
      setState(() {
      _astroList = value; 
      });
    });
    
  }


  @override
  Widget build(BuildContext context) {
    factList = facts.facts;
    randomFact = facts.randomFact();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Residents of Space", style: TextStyle(color: Colors.lightGreenAccent),),
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
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightGreenAccent),
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.info_outline),
                          title: Text('Random ISS Fact!', style: TextStyle(color: Colors.lightGreenAccent),),
                          subtitle: Text(randomFact),
                        ),
                      ],
                    ),
                  ),
                    
                ]
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
              ),
              // Info from API below
              Text (
                "There are currently ${_astroList.length} astronauts in space. They are:",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightGreenAccent),
              ),
              Expanded (
                child: 
                    ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      itemCount: _astroList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.transparent,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Text(
                                  '${_astroList.elementAt(index).name.substring(0, 1)}',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightGreenAccent),
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.5,
                                ),
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