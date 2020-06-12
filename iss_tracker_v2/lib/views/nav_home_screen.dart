
import 'package:iss_tracker_v2/components/theme.dart';
import 'package:iss_tracker_v2/components/drawer_user_controller.dart';
import 'package:iss_tracker_v2/components/drawer_home.dart';
import 'package:flutter/material.dart';
import 'package:iss_tracker_v2/views/astro_info.dart';
import 'package:iss_tracker_v2/views/iss_history.dart';
import 'package:iss_tracker_v2/views/map_page.dart';
import 'package:iss_tracker_v2/views/next_pass.dart';
import 'package:iss_tracker_v2/views/space_news.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = LocationMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView,
            
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = LocationMap();
        });
      } else if (drawerIndex == DrawerIndex.Crew) {
        setState(() {
          screenView = AstroInfo();
        });
      } else if (drawerIndex == DrawerIndex.PassTimes) {
        setState(() {
          screenView = NextPassTimes();
        });
      } else if (drawerIndex == DrawerIndex.NewsFeed) {
        setState(() {
          screenView = SpaceNews();
        });
      } else if (drawerIndex == DrawerIndex.History) {
        setState(() {
          screenView = ISSHistory();
        });
      }
    }
  }
}