import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:iss_tracker_v2/components/settings.dart';
=======
>>>>>>> 96ba89f0e69b6c06c2a72d5f5b0caaae4d157ca9

class ISSHistory extends StatefulWidget {
  @override
  _ISSHistoryState createState() => _ISSHistoryState();
}

class _ISSHistoryState extends State<ISSHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        backgroundColor: Settings.isLightTheme ? Colors.blueGrey[400] : Colors.black54,
=======
        backgroundColor: Colors.blueGrey[400],
>>>>>>> 96ba89f0e69b6c06c2a72d5f5b0caaae4d157ca9
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
<<<<<<< HEAD
            colors: Settings.isLightTheme ? [Colors.blueGrey[400], Colors.indigo]
              : [Colors.black87, Colors.black],
=======
            colors: [Colors.blueGrey[400], Colors.indigo]
>>>>>>> 96ba89f0e69b6c06c2a72d5f5b0caaae4d157ca9
          )
        ),
      ),
    );
  }
}