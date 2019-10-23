import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:iss_tracker/history.dart';

// Pages / Routes
import 'issInfo.dart';
import 'nextPass.dart';
import 'locmap.dart'; 
import 'history.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISS Tracker',
      theme: ThemeData.dark(),
      home: PageNav(),
    );
  }
}

class PageNav extends StatefulWidget {
  @override
  _PageNavState createState() => _PageNavState();
}

class _PageNavState extends State<PageNav> {
  int currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        initialSelection: 0,
        tabs: [
          TabData(
            iconData: Icons.satellite,
            title: "Location",
            
            onclick: () {
              final FancyBottomNavigationState fState = bottomNavigationKey.currentState;
              fState.setPage(0);
            }),
          TabData(
            iconData: Icons.scatter_plot,
            title: "Information",
            onclick: () {
              final FancyBottomNavigationState fState = bottomNavigationKey.currentState;
              fState.setPage(1);
            }),
          TabData(
            iconData: Icons.schedule,
            title: "Next Pass",
            onclick: () {
              final FancyBottomNavigationState fState = bottomNavigationKey.currentState;
              fState.setPage(2);
            }),
          TabData(
            iconData: Icons.calendar_view_day,
            title: "History",
            onclick: () {
              final FancyBottomNavigationState fState = bottomNavigationKey.currentState;
              fState.setPage(3);
            }
          )
        ],
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
        });
      },
    ),
  );
}


  _getPage(int page) {
    switch (page) {

      // ISS current location route
      case 0:
        return MapLocation();
      
      // ISS Info route
      case 1:
        return ISSInfo();

      // ISS Next Pass route
      case 2:
        return NextPass();

      // Settings route
      case 3:
        return History();

    }
  }
}