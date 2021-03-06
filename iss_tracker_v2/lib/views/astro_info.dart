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
import 'package:iss_tracker_v2/components/wiki_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clay_containers/clay_containers.dart';

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


//  static final String url = 'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=250&pilimit=20&wbptterms=description&gpssearch=ChrisCassidy&gpslimit=20';

class AstroInfo extends StatefulWidget {
  @override
  _AstroInfoState createState() => _AstroInfoState();
}

class _AstroInfoState extends State<AstroInfo> {
  List<Astronaut> _astroList = [];  // List of astronauts
  //List<String> _astroImgUrls = [];
  //String _astroUrl;

  Future<List> astroListBuilder() async {
    var astroList = await fetchAstros();
    return astroList.astros;
  }

  
  @override
  void initState() {
    super.initState();

    Settings.getLightMode();

    // Build list of astronauts and set to state list
    astroListBuilder().then((value) {
      setState(() {
      _astroList = value; 
      });

      /*
      WikiPhoto.fetchWikiPhoto(
        'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=250&pilimit=20&wbptterms=description&gpssearch=ChrisCassidy&gpslimit=20'
      ).then((value) {
        setState(() {
          _astroUrl = value;
        });
      });
      */

      /*
      for (var astro in _astroList) {
        print ('astro: ${astro.name}');
        
        WikiPhoto.fetchWikiPhoto(
          'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=250&pilimit=20&wbptterms=description&gpssearch=${astro.name.replaceAll(" ", "")}&gpslimit=20'
        ).then((value) {
          _astroImgUrls.add(value);
          print('\nVal: $value');
        });
        print('\nAstro IMGs: $_astroImgUrls');
      }
      */
      //buildAstroImgs();
      //addToList();
    });

  }



  Future<String> buildAstroImgs(name) async{
    print('\nName: $name \n');
    name.replaceAll(' ', ''); // Strip spaces for use in url
    String url = 'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=250&pilimit=20&wbptterms=description&gpssearch=$name&gpslimit=20';
    
    String _imgUrl;
    WikiPhoto.fetchWikiPhoto(url).then((value) {
      _imgUrl = value;
      
      print('\nImgURL: $_imgUrl');
    });

      return _imgUrl;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Settings.isLightTheme ? Colors.white : Color(0xFF121212),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: ClayContainer(
                    emboss: Settings.isLightTheme ? false : true,
                    depth: 50,
                    color: Settings.isLightTheme ? Colors.white : Color(0xFF393b44),
                    height: 150,
                    width: 150,
                    customBorderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: ClayText(
                          '${_astroList.length}',
                          style: TextStyle(
                            fontSize: 75,
                          ),
                          emboss: false,
                          depth: 10,
                          spread: Settings.isLightTheme ? 10 : 0,
                          textColor: Settings.isLightTheme ? Colors.black87 : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Center(
                    child: ClayText(
                      "People in Space",
                      textColor: Settings.isLightTheme ? Colors.black87 : Colors.white,
                      spread: Settings.isLightTheme ? 10: 0,
                      depth: 10,
                      emboss: true,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'WorkSans',
                        fontSize: 24.0
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48, bottom: 12),
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
                child: ClayContainer(
                  color: Colors.white,
                    emboss: true,
                    height: 75,
                    width: 75,
                    borderRadius: 50,
                    depth: 40,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    ),
                  )
                ) :
                ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: _astroList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: Settings.isLightTheme ? 0: 8)),
                        ClayContainer(
                          depth: 40,
                          borderRadius: 10,
                          color: Settings.isLightTheme ? Colors.white : Color(0xFF121212),
                          emboss: index % 2 == 1 ? false : true,
                          child: ListTile(
                            onTap: () async {
                              // Navigate to astronaut's wiki page
                              String url = 'https://en.wikipedia.org/wiki/Special:Search/${_astroList.elementAt(index).name}';
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            leading: ClayContainer(
                              color: Colors.white,
                              borderRadius: 100,
                              curveType: CurveType.convex,
                              depth: 30,
                              spread: Settings.isLightTheme ? 10 : 0,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  ''
                                ),
                                backgroundColor: Colors.black12,
                              ),
                            ),
                            title: ClayText(
                              'Name: ${_astroList.elementAt(index).name}',
                              style: TextStyle(
                                color: Settings.isLightTheme ? Colors.black : Colors.white,
                              ),
                              emboss: true,
                              depth: 10,
                              spread: Settings.isLightTheme ? 10 : 0,
                              textColor: Settings.isLightTheme ? Colors.black : Colors.white,
                            ),
                            subtitle: Text(
                              'Craft: ${_astroList.elementAt(index).craft}',
                              style: TextStyle(
                                color: Colors.blueGrey[200],
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 8.0),
                      )],
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