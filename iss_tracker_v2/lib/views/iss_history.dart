import 'package:flutter/material.dart';
import 'package:iss_tracker_v2/components/settings.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ISSHistory extends StatefulWidget {
  @override
  _ISSHistoryState createState() => _ISSHistoryState();
}


TimelineTile historyTile({double lineX, double height, String leftText, String rightText}) {
  return TimelineTile(
    alignment: TimelineAlign.manual,
    lineX: lineX,
    topLineStyle: LineStyle(color: Colors.black),
    bottomLineStyle: LineStyle(color: Colors.black),
    indicatorStyle: IndicatorStyle(
      color: Colors.white,
      width: 16.0,
    ),
    leftChild: Container(
      color: Colors.white24,
      child: Center(
        child: Text(
          leftText,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'WorkSans',
            fontWeight: FontWeight.bold
          ),
        )
      )
    ),
    rightChild: Container(
      height: height,
      color: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          rightText,
          style: TextStyle(
            color: Colors.blueGrey[100]
          ),
        ),
      ),
    ),
  );
}

Padding headerDivider({String header, Color dividerColour, Color textColour}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        Padding(
          padding: EdgeInsets.only(top: 8.0, left: 32.0),
          child: Text(
            header,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: textColour,

            ),
          ),
        ),
        Divider(
          color: dividerColour,
          thickness: 2.0,
        )
      ]
    ),
  );
}


class _ISSHistoryState extends State<ISSHistory> {

  @override
  void initState() { 
    

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Settings.isLightTheme ? Colors.blueGrey[400] : Colors.black54,
        centerTitle: true,
        title: Text(
          'History of the ISS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'WorkSans'
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: Settings.isLightTheme ? [Colors.blueGrey[400], Colors.indigo]
              : [Colors.black87, Colors.black],
          )
        ),
        child: ListView(
          children: <Widget> [
            headerDivider(
              header: '1998',
              textColour: Colors.orange[600],
              dividerColour: Colors.orangeAccent,
            ),
            historyTile(
              lineX: 0.2,
              leftText: 'Oct. 20',
              rightText: "A Russian Proton rocket launches the first module of the station, Zarya (Sunrise)."
            ),
            Divider(
              height: 16.0,
              thickness: 2.0,
              color: Colors.white54,
            ),
            historyTile(
              lineX: 0.2,
              leftText: 'Dec. 4',
              rightText: "Unity, the first U.S.-built component of the station, launches on the first"
                +" shuttle mission dedicated to the assembly of the outpost.",
            ),
            headerDivider(
              header: '2000-01',
              textColour: Colors.orange[600],
              dividerColour: Colors.orangeAccent,
            ),
            historyTile(
              lineX: 0.2,
              leftText: 'Nov. 30',
              rightText: "The P6 truss is installed. This component includes the first piece of the main"
                +" solar-cell array that powers the station.",
            ),
            Divider(
              height: 16.0,
              thickness: 2.0,
              color: Colors.white54,
            ),
            historyTile(
              lineX: 0.2,
              leftText: 'Feb. 7',
              rightText: "Destiny, the U.S. laboratory module, becomes part of the station. Destiny is still"
                +" the primary research facility for U.S. payloads.",
            ),
            Divider(
              height: 16.0,
              thickness: 2.0,
              color: Colors.white54,
            ),
            historyTile(
              lineX: 0.2,
              leftText: 'Apr. 19',
              rightText: "Canadarm2, the station's robotic arm, is added. The key robotic system plays a key role"
                +" in the assembly of the station.",
            ),
            headerDivider(
              header: '2002-03',
              textColour: Colors.orange[600],
              dividerColour: Colors.orangeAccent,
            ),
            historyTile(
              lineX: 0,
              leftText: '',
              rightText: "Four years after its first component was put into orbit, the station is capable of"
                +" sustaining a permanent crew of three. The first research module, Destiny, an American"
                +" laboratory, becomes operational."
            ),
            Divider(height: 16.0, thickness: 2.0, color: Colors.white54),
            historyTile(
              lineX: 0.2,
              leftText: 'Apr. 8',
              rightText: "The central segment of the station truss, S0, is installed on top of Destiny",
            ),
            Divider(height: 16.0, thickness: 2.0, color: Colors.white54),
            historyTile(
              lineX: 0.2,
              leftText: 'Apr. 8',
              rightText: "The space shuttle Columbia disintegrates during atmospheric re-entry. The construction"
                +" is halted.",
            ),
            headerDivider(
              header: '2003-2006',
              textColour: Colors.orange[600],
              dividerColour: Colors.orangeAccent,
            ),
            historyTile(
              lineX: 0,
              leftText: '',
              rightText: "During the space shuttle moratorium (2003-2006) and after the end of the program,"
                +" the Russian spacecraft Soyuz TMA became the main transport to the station. The"
                +" capsule has more than 47 years of service with the same basic design.",
            ),
            headerDivider(
              header: '2008-09',
              textColour: Colors.orange[600],
              dividerColour: Colors.orangeAccent,
            ),
            historyTile(
              lineX: 0.2,
              leftText: 'July 26',
              rightText: "The space shuttle Discovery returns to the station after three years. The"
                +" mission delivers supplies to the station and tests safety procedures.",
            ),
            Divider(
              height: 16.0,
              thickness: 2.0,
              color: Colors.white54,
            ),
            historyTile(
              lineX: 0.2,
              leftText: 'Feb 7.',
              rightText: "The crew of the space shuttle Atlantis delivers and install the European Space"
                +" Agency's Columbus laboratory.",
            ),
            Divider(
              height: 16.0,
              thickness: 2.0,
              color: Colors.white54,
            ),
            historyTile(
              lineX: 0.2,
              leftText: 'March 15',
              rightText: "The space shuttle Discovery delivers the station's final major U.S. truss segment,"
                +" S6, and its final pair of power-generating solar array wings.",
            ),
            headerDivider(
              header: '2010-11',
              textColour: Colors.orange[600],
              dividerColour: Colors.orangeAccent,
            ),
            historyTile(
              lineX: 0.2,
              leftText: 'Nov 2',
              rightText: "The station celebrates the 10-year anniversary of its continuous human occupation."
                +" Since Expedition 1 in the fall of 2000, 202 people have visited the station.",
            ),
            Divider(
              height: 16.0,
              thickness: 2.0,
              color: Colors.white54,
            ),
            historyTile(
              lineX: 0.2,
              leftText: 'Feb 24',
              rightText: "The space shuttle Discovery launches on its final planned mission to deliver the"
                +" Permanent Multipurpose Module, Leonardo, and Express Logistics Carrier 4 to the ISS,"
                +" as well as equipment and supplies. Among the cargo aboard the Leonardo was Robonaut 2,"
                +" a robot that could be a precursor of new humanoid remote devices to help during space"
                "walks.",
            ),
            
            headerDivider(
              header: '2016',
              textColour: Colors.orange[600],
              dividerColour: Colors.orangeAccent,
            ),
            historyTile(
              lineX: 0.2,
              leftText: 'May 28',
              rightText: "BEAM, or Bigelow Expandable Activity Module arrived at the ISS on April 10th,"
                +" and was expanded and pressurized for use on May 28th. BEAM is an experiment to test &"
                +" validate expandable habitats for future crews traveling deep space.",
            ),
            Divider(
              height: 16.0,
              thickness: 2.0,
              color: Colors.white54,
            ),
            historyTile(
              lineX: 0.2,
              leftText: 'July 18',
              rightText: "The 2nd iteration of the International Docking Adapter, IDA-2, was launched on the SpaceX"
                +" CRS-18 mission in July 2019. It's first docking was achievched with the arrival of Crew Dragon"
                +" Demo-1, March 3 2019. IDA-3 was launched in July 2019 to provide additional docking to the station",
            ),
            Divider(
              height: 16.0,
              thickness: 2.0,
              color: Colors.white54,
            ),
  
          ]
        )
      ),
    );
  }
}