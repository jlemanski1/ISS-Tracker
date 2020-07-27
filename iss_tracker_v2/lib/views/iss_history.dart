import 'package:flutter/material.dart';
import 'package:iss_tracker_v2/components/settings.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ISSHistory extends StatefulWidget {
  @override
  _ISSHistoryState createState() => _ISSHistoryState();
}


TimelineTile historyTile({double lineX, double height, Text leftText, Text rightText}) {
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
      child: Center(child: leftText)
    ),
    rightChild: Container(
      height: height,
      color: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: rightText,
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
              textColour: Colors.white,
              dividerColour: Colors.white,
            ),
            historyTile(
              lineX: 0.2,
              height: 48,
              leftText: Text('Oct. 20'),
              rightText: Text("A Russian Proton rocket launches the first module of the station, Zarya (Sunrise)."),
            ),
            Divider(
              height: 16.0,
              thickness: 2.0,
              color: Colors.white54,
            ),
            historyTile(
              lineX: 0.2,
              height: 64,
              leftText: Text('Dec. 4'),
              rightText: Text("Unity, the first U.S.-built component of the station, launches on the first"
                +" shuttle mission dedicated to the assembly of the outpost."),
            ),
            headerDivider(
              header: '2000-01',
              textColour: Colors.white,
              dividerColour: Colors.white,
            ),
            historyTile(
              lineX: 0.2,
              height: 64,
              leftText: Text('Nov. 30'),
              rightText: Text("The P6 truss is installed. This component includes the first piece of the main"
                +" solar-cell array that powers the station.")
            ),
            Divider(
              height: 16.0,
              thickness: 2.0,
              color: Colors.white54,
            ),
            historyTile(
              lineX: 0.2,
              height: 64,
              leftText: Text('Feb. 7'),
              rightText: Text("Destiny, the U.S. laboratory module, becomes part of the station. Destiny is still"
                +" the primary research facility for U.S. payloads.")
            ),
            Divider(
              height: 16.0,
              thickness: 2.0,
              color: Colors.white54,
            ),
            historyTile(
              lineX: 0.2,
              height: 64,
              leftText: Text('Apr. 19'),
              rightText: Text("Canadarm2, the station's robotic arm, is added. The key robotic system plays a key role"
                +" in the assembly of the station.")
            ),
            headerDivider(
              header: '2002-03',
              textColour: Colors.white,
              dividerColour: Colors.white,
            ),
            historyTile(
              lineX: 0.2,
              height: 64,
              leftText: Text('DATE'),
              rightText: Text("Four years after its first component was put into orbit, the station is capable of"
                +" sustaining a permanent crew of three. The first research module, Destiny, an American"
                +" laboratory, becomes operational.")
            ),
            Divider(height: 16.0, thickness: 2.0, color: Colors.white54),
            historyTile(
              lineX: 0.2,
              height: 64,
              leftText: Text('Apr. 8'),
              rightText: Text("The central segment of the station truss, S0, is installed on top of Destiny"),
            ),
            Divider(height: 16.0, thickness: 2.0, color: Colors.white54),
            historyTile(
              lineX: 0.2,
              height: 64,
              leftText: Text('Apr. 8'),
              rightText: Text("The space shuttle Columbia disintegrates during atmospheric re-entry. The construction"
                +" is halted."),
            ),
            Divider(
              height: 16.0,
              thickness: 2.0,
              color: Colors.white54,
            ),
            headerDivider(
              header: '2003-2006',
              textColour: Colors.white,
              dividerColour: Colors.white,
            ),
            historyTile(
              lineX: 0.2,
              height: 64,
              leftText: Text(''),
              rightText: Text('Desc')
            ),
            Divider(
              height: 16.0,
              thickness: 2.0,
              color: Colors.white54,
            ),
            headerDivider(
              header: '2008-09',
              textColour: Colors.white,
              dividerColour: Colors.white,
            ),
            historyTile(
              lineX: 0.2,
              height: 64,
              leftText: Text(''),
              rightText: Text('Desc')
            ),
            Divider(
              height: 16.0,
              thickness: 2.0,
              color: Colors.white54,
            ),
            headerDivider(
              header: '2010-11',
              textColour: Colors.white,
              dividerColour: Colors.white,
            ),
            historyTile(
              lineX: 0.2,
              height: 64,
              leftText: Text(''),
              rightText: Text('Desc')
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