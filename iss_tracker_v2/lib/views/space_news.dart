import 'package:clay_containers/widgets/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:iss_tracker_v2/components/news_card.dart';
import 'package:iss_tracker_v2/components/settings.dart';

class SpaceNews extends StatefulWidget {
  @override
  _SpaceNewsState createState() => _SpaceNewsState();
}

class _SpaceNewsState extends State<SpaceNews> {

  @override
  void initState() {
    Settings.getLightMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Settings.isLightTheme ? Colors.white : Color(0xFF121212),
        child: Center(
          child: Column(
            children: <Widget>[
              ClayContainer(
                depth: 50,
                height: 75,
                width: MediaQuery.of(context).size.width,
                color: Settings.isLightTheme ? Colors.white : Color(0xFF393b44),
                emboss: Settings.isLightTheme ? false : true,
                customBorderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Center(
                    child: Text(
                      'Space News',
                      style: TextStyle(
                        color: Settings.isLightTheme ? Colors.black : Colors.white,
                        fontFamily: 'WorkSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(child: NewsCard()),
            ],
          )
        )
      ),
    );
  }
}