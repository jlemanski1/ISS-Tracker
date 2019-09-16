/*
  Page displaying settings and allows the user to configure the app-level settings
  such set units (kph/mph), location, etc.
*/
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History of the Space Station"),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
            Card(
              color: Colors.transparent,
              child: ListTile(
                leading: Text('2011', style: TextStyle(fontWeight: FontWeight.bold),),
                title: Text('Final Touches'),
                subtitle: Text(
                  "By 2011, the station's habitable components had been completely installed;"
                  +" as well as the full array of power cells. The ISS relies mainly on Russian Soyuz capsules"
                  +" to receive new supplies and exchange crew."
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                selected: false,
                onTap: () {
                  showModalBottomSheet(context: context, builder: (builder) {
                  return Column(
                    children: <Widget>[
                      Card(
                        child: ListTile(
                          title: Text("Nov. 2, 2010", style: TextStyle(color: Colors.orangeAccent),),
                          subtitle: Text(
                            "The station celebrates the 10-year anniversary of its continuous human occupation."
                            +" Since Expedition 1 in the fall of 2000, 202 people have visited the station at that point."
                            ),
                          ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
                      Card(
                        child: ListTile(
                          title: Text("Feb. 24, 2011", style: TextStyle(color: Colors.orangeAccent),),
                          subtitle: Text(
                            "The space shuttle Discovery launches on its final planned mission to deliver the"
                            +" Permanent Multipurpose Module, Leonardo, and Express Logistics Carrier 4 to the ISS"
                            +", as well as equipment and supplies. Among the cargo aboard the Leonardo was Robonaut 2,"
                            +" a robot that could be a precursor of new humanoid remote devices to help during spacewalks."
                            ),
                          ),
                      ),
                    ],
                  );
                });
                }
              )
            ),
            Card(
              color: Colors.transparent,
              child: ListTile(
                leading: Text('2008', style: TextStyle(fontWeight: FontWeight.bold),),
                title: Text('The Last Pieces'),
                subtitle: Text(
                  "The construction of the station halted following the Columbia disaster in 2003."
                  +" In 2006 the assembly of the station resumes, and by 2008, the majority of the"
                  +" main components of the orbital outpost were in place."
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                selected: false,
                onTap: () {
                  showModalBottomSheet(context: context, builder: (builder) {
                  return Column(
                    children: <Widget>[
                      Text("Placeholder"),
                    ],
                  );
                });
                }
              )
            ),
            Card(
              color: Colors.transparent,
              child: ListTile(
                leading: Text('2002', style: TextStyle(fontWeight: FontWeight.bold),),
                title: Text('Rapid Growth'),
                subtitle: Text(
                  "Four years after its first component was put into orbit, the station is capable of"
                  +" sustaining a permanent crew of three. The first research module, Destiny, an American"
                  +" laboratory, becomes operational"
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                selected: false,
                onTap: () {
                  showModalBottomSheet(context: context, builder: (builder) {
                  return Column(
                    children: <Widget>[
                      Text("Placeholder"),
                    ],
                  );
                });
                }
              )
            ),
            Card(
              color: Colors.transparent,
              child: ListTile(
                leading: Text('1998', style: TextStyle(fontWeight: FontWeight.bold),),
                title: Text('Fully Energized'),
                subtitle: Text(
                  "The Russian-built Functional Cargo Block, known as Zarya (Sunrise), is launched into orbit to"
                  +" become the first module of the station. This component gives the outpost its initial power,"
                  +" storage, and propulsion capabilities."
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                selected: false,
                onTap: (){
                  showModalBottomSheet(context: context, builder: (builder) {
                  return Column(
                    children: <Widget>[
                      Text("Placeholder"),
                    ],
                  );
                });
                }
              )
            ),
          ],
          
        ),
      ),
    );
  }
}