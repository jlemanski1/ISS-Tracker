import 'package:flutter/material.dart';
import 'package:iss_tracker_v2/components/settings.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ISSHistory extends StatefulWidget {
  @override
  _ISSHistoryState createState() => _ISSHistoryState();
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
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineX: 0.2,
              topLineStyle: LineStyle(color: Colors.black),
              bottomLineStyle: LineStyle(color: Colors.black),
              indicatorStyle: IndicatorStyle(
                color: Colors.white,
                width: 16.0,

              ),
              leftChild: Container(
                color: Colors.white24,
                child: Center(child: Text('Year'))
              ),
              rightChild: Container(
                height: 64,
                color: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Desc'),
                ),
              ),
            ),
          ]
        )
      ),
    );
  }
}