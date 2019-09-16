/*
  Page displaying settings and allows the user to configure the app-level settings
  such set units (kph/mph), location, etc.
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
        title: Text("History of the Space Station"),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            Card(
              color: Colors.transparent,
              child: ListTile(
                leading: Icon(Icons.history),
                title: Text('Placeholder'),
                subtitle: Text('placeholder'),
              )
            ),
            Card(
              color: Colors.transparent,
              child: ListTile(
                leading: Icon(Icons.history),
                title: Text('Placeholder'),
                subtitle: Text('placeholder'),
              )
            ),
          ],
          
        ),
      ),
    );
  }
}