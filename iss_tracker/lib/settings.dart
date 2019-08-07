/*
  Page displaying settings and allows the user to configure the app-level settings
  such set units (kph/mph), location, etc.
*/
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: Text("Nothing here yet either... Should get on that")),
    );
  }
}