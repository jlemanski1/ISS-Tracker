/*
  Page displaying history and major milestones during the assembly and life of the Internation
  Space Station
*/
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
        title: Text("History of the Space Station", style: TextStyle(color: Colors.orangeAccent)),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            Padding(padding: EdgeInsets.symmetric(vertical: 2.0),),
            Card(
              color: Colors.transparent,
              child: ListTile(
                leading: Text('1998', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                title: Text('Fully Energized', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
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
                      Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
                      Card(
                        child: ListTile(
                          title: Text("Oct. 20, 1998", style: TextStyle(color: Colors.orangeAccent),),
                          subtitle: Text(
                            "A Russian Proton rocket launches the first module of the station: Zarya (Sunrise)."
                            ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
                      Card(
                        child: ListTile(
                          title: Text("Dec. 4, 1998", style: TextStyle(color: Colors.orangeAccent),),
                          subtitle: Text(
                            "Unity, the first U.S.-built component of the station, launches with the first"
                            +" space shuttle mission dedicated to the assembly of the outpost."
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
                leading: Text('2000', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                title: Text('All Aboard!', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                subtitle: Text(
                  "Astronaut Bill Shepherd and cosmonauts Yuri Gidzenko and Sergei Krikalev become the"
                  +" first crew members aboard the station. They stayed in obrit for several months."
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                selected: false,
                onTap: () {
                  showModalBottomSheet(context: context, builder: (builder) {
                  return Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
                      Card(
                        child: ListTile(
                          title: Text("Nov. 30, 2000", style: TextStyle(color: Colors.orangeAccent),),
                          subtitle: Text(
                            "The P6 truss is installed. This component includes the first piece of the main"
                            +" solar-cel array that powers the station."
                            ),
                          ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
                      Card(
                        child: ListTile(
                          title: Text("Feb. 7, 2001", style: TextStyle(color: Colors.orangeAccent),),
                          subtitle: Text(
                            "Destiny, the U.S. laboratory module, becomes part of the station. Destiny is still"
                            +" the primary research facility for U.S. payloads."
                            ),
                          ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
                      Card(
                        child: ListTile(
                          title: Text("April 19, 2001", style: TextStyle(color: Colors.orangeAccent),),
                          subtitle: Text(
                            "Canadarm2, the station's robotic arm, is added. The key robotic system plays a key role"
                            +" in the assembly of the station."
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
                leading: Text('2002', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                title: Text('Rapid Growth', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
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
                      Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
                      Card(
                        child: ListTile(
                          title: Text("April 8, 2002", style: TextStyle(color: Colors.orangeAccent),),
                          subtitle: Text(
                            "The central segment of the station truss, S0, is installed on top of Destiny"
                            ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
                      Card(
                        child: ListTile(
                          title: Text("Feb. 1, 2003", style: TextStyle(color: Colors.orangeAccent),),
                          subtitle: Text(
                            "The space shuttle Columbia disintegrates during atmospheric reentry. The construction"
                            +" is halted."
                            ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
                      Card(
                        child: ListTile(
                          title: Text("2003-2006", style: TextStyle(color: Colors.orangeAccent),),
                          subtitle: Text(
                            "During the space shuttle moratorium (2003-2006) and after the end of the program,"
                            +" the Russian spacecraft Soyuz TMA became the main transport to the station. The"
                            +" capsule has more than 47 years of service with the same basic design."
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
                leading: Text('2008', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                title: Text('The Last Pieces', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
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
                      Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
                      Card(
                        child: ListTile(
                          title: Text("July 26, 2006", style: TextStyle(color: Colors.orangeAccent),),
                          subtitle: Text(
                            "The space shuttle Discovery returns to the station after three years. The"
                            +" mission delivers supplies to the station and tests safety procedures."
                            ),
                          ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
                      Card(
                        child: ListTile(
                          title: Text("Feb. 7, 2008", style: TextStyle(color: Colors.orangeAccent),),
                          subtitle: Text(
                            "The crew of the space shuttle Atlantis delivers and install the European Space"
                            +" Agency's Columbus laboratory."
                            ),
                          ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
                      Card(
                        child: ListTile(
                          title: Text("March 15, 2009", style: TextStyle(color: Colors.orangeAccent),),
                          subtitle: Text(
                            "The space shuttle Discovery delivers the station's final major U.S. truss segment"
                            +", S6, and its final pair of power-generating solar array wings."
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
                leading: Text('2011', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                title: Text('Final Touches', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
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
                      Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
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
                      Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
                    ],
                  );
                });
                }
              )
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 8.0),),
        
          ],
          
        ),
      ),
    );
  }
}