import 'package:flutter/material.dart';

class SpaceNews extends StatefulWidget {
  @override
  _SpaceNewsState createState() => _SpaceNewsState();
}

class _SpaceNewsState extends State<SpaceNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        centerTitle: true,
        title: Text("Space News",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'WorkSans',
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey[400], Colors.pink[200]],
          )
        ),
      
      ),
    );
  }
}