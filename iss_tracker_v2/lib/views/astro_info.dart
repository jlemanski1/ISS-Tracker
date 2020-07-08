/*
  Page displaying some fun facts about the ISS, including the astronauts currently
  onboard.
*/
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iss_tracker_v2/components/settings.dart';
import 'package:url_launcher/url_launcher.dart';

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
        backgroundColor: Settings.isLightTheme ? Colors.blueGrey[400] : Colors.black54,
        centerTitle: true,
        title: Text(
          'Astronauts',
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
            colors: Settings.isLightTheme ? [Colors.blueGrey[400], Colors.blue[300]]
              : [Colors.black87, Colors.black],
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 32.0, left: 8.0, bottom: 24.0),
              child: Text(
                "There are ${_astroList.length} people currently in space, they are:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'WorkSans',
                  color: Settings.isLightTheme ? Colors.black : Colors.blueGrey[300],
                  fontSize: 24.0
                ),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: Text(
                'Tap on the tiles to learn more about each crew member',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'WorkSans',
                  color: Settings.isLightTheme ? Colors.black : Colors.blueGrey[300],
                  fontSize: 12.0
                ),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            Expanded (
              flex: 1,
              child: _astroList.length == 0 ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                  )
                ) :
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
                            onTap: () async {
                              // Navigate to astronaut's wiki page
                              String url = 'https://en.wikipedia.org/wiki/Special:Search/${_astroList.elementAt(index).name}';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            // TODO: wiki api fetch image url from page
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(''),
                            ),
                            title: Text(
                              'Name: ${_astroList.elementAt(index).name}',
                              style: TextStyle(
                                color: Settings.isLightTheme ? Colors.black : Colors.white,
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