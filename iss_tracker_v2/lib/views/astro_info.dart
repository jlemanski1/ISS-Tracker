/*
  Page displaying some fun facts about the ISS, including the astronauts currently
  onboard.
*/
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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



class AstroInfo extends StatefulWidget {
  @override
  _AstroInfoState createState() => _AstroInfoState();
}

class _AstroInfoState extends State<AstroInfo> {
  List<Astronaut> _astroList = [];  // List of astronauts

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
        backgroundColor: Colors.blueGrey[400],
        centerTitle: true,
        title: Text(
          'Space Farers',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'WorkSans',
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey[400], Colors.blue[300]]
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 32.0, left: 8.0, bottom: 24.0),
              child: Text(
                "The ${_astroList.length} people currently in space, are:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'WorkSans',
                  color: Colors.black,
                  fontSize: 24.0
                ),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            
          
            Expanded (
              flex: 1,
              child: 
                ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: _astroList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.black38,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          
                          ListTile(
                            leading: Text(
                              '${_astroList.elementAt(index).name.substring(0, 1)}',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                              textAlign: TextAlign.center,
                              textScaleFactor: 1.5,
                            ),
                            title: Text(
                              'Name: ${_astroList.elementAt(index).name}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              'Craft: ${_astroList.elementAt(index).craft}',
                              style: TextStyle(
                                color: Colors.blueGrey[200],
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    );
                  },
                ),
            ),
          ],
        ),
      )
    );
  }

}