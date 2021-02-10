import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iss_tracker_v2/components/settings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LivestreamPage extends StatefulWidget {
  @override
  _LivestreamPageState createState() => _LivestreamPageState();
}

class _LivestreamPageState extends State<LivestreamPage> {
  YoutubePlayerController _youtubeController;
  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;

  //double _volume = 100;
  //bool _muted = true;
  bool _isPlayerReady = false;
  final String _videoId = 'XBPjVzSoepo';

  @override
  void initState() {
    Settings.getLightMode();

    super.initState();
    _youtubeController = YoutubePlayerController(
    initialVideoId: _videoId,
    flags: const YoutubePlayerFlags(
      mute: true,
      autoPlay: true,
      disableDragSeek: true,
      loop: false,
      isLive: true,
      forceHD: false,
      enableCaption: false,
      hideControls: true,
      ),
    )..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }


  @override
  void deactivate() {
    // Pause video while navigating away from page
    _youtubeController.pause();  
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  _youtubeController.dispose();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_youtubeController.value.isFullScreen) {
      setState(() {
        _playerState = _youtubeController.value.playerState;
        _videoMetaData = _youtubeController.metadata;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _youtubeController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _youtubeController.metadata.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          )
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          _youtubeController.load(_videoId);
        },
        
      ),
      builder: (context, player) => Scaffold(
        body: Container(
          color: Settings.isLightTheme ? Colors.white : Color(0xFF121212),
          child: Column(
            children: <Widget>[
              ClayContainer(
                depth: 40,
                height: 75,
                color: Settings.isLightTheme ? Colors.white : Color(0xFF393b44),
                width: MediaQuery.of(context).size.width,
                customBorderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                    "HD Earth View",
                    style: TextStyle(
                      color: Settings.isLightTheme ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'WorkSans',
                      fontSize: 24,
                      ),
                    ),
                  ),
                ),
                
              ),
              Padding(padding: EdgeInsets.only(top: 8.0, bottom: 8.0),),
              ClayContainer(
                depth: 40,
                borderRadius: 10,
                spread: Settings.isLightTheme ? 5 : 3,
                color: Settings.isLightTheme ? Colors.white : Color(0xFF121212),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: player,
                )
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 2.0),),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClayContainer(
                  depth: 40,
                  borderRadius: 10,
                  emboss: true,
                  spread: Settings.isLightTheme ? 5 : 3,
                  color: Settings.isLightTheme ? Colors.white : Color(0xFF121212),
                  child: ListTile(
                    leading: Icon(
                      Icons.info,
                      color: Colors.amberAccent[400],
                    ),
                    title: Text(
                      'HDEV payload reached end-of-life Aug. 22, 2019',
                      style: TextStyle(
                        color: Settings.isLightTheme ? Colors.black : Colors.white,
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    subtitle: Text(
                      'A continuous feed of past recordings will be shown.',
                      style: TextStyle(
                        color: Settings.isLightTheme ? Colors.black : Colors.white,
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 0.0, bottom: 0.0),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClayContainer(
                  depth: 40,
                  borderRadius: 10,
                  spread: Settings.isLightTheme ? 5 : 3,
                  color: Settings.isLightTheme ? Colors.white : Color(0xFF121212),
                  child: Column(
                    children: <Widget> [
                      Text(
                        'Mission Information',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          fontFamily: 'WorkSans',
                          color: Settings.isLightTheme ? Colors.black : Colors.white,
                        )
                      ),
                      ListTile(
                        title: Text(
                          'The High Definition Earth Viewing (HDEV) investigation places four different commercial'
                          +' high definition cameras external to the ISS on the Columbus External Facility',
                          style: TextStyle(
                            color: Settings.isLightTheme ? Colors.blueGrey[800] : Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Validate space-based performance of the cameras in a variety of modes.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Settings.isLightTheme ? Colors.black : Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          "Assessing the hardware's ability to survive and function in the extreme radioactive"
                          +" of Low Earth Orbit (LEO) while taking Earth imagery.",
                          style: TextStyle(
                            color: Settings.isLightTheme ? Colors.blueGrey[800] : Colors.white,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Educational Outreach',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Settings.isLightTheme ? Colors.black : Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          'NASA HUNCH program students fabricated some of the HDEV flight components'
                          +' and most of the HDEV operation is performed by student teams.',
                          style: TextStyle(
                            color: Settings.isLightTheme ? Colors.blueGrey[800] : Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                      )
                    ]
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClayContainer(
                  depth: 40,
                  borderRadius: 10,
                  emboss: true,
                  spread: Settings.isLightTheme ? 5 : 3,
                  color: Settings.isLightTheme ? Colors.white : Color(0xFF121212),
                  child: ListTile(
                    leading: Icon(
                      Icons.web,
                      color: Settings.isLightTheme ? Colors.black : Colors.white,
                    ),
                    title: Text(
                      'View NASA mission page for more information.',
                      style: TextStyle(
                        color: Settings.isLightTheme ? Colors.black : Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    onTap: () async {
                      // Navigate to NASA mission page
                      const url = 'https://www.nasa.gov/mission_pages/station/research/experiments/explorer/Investigation.html?#id=892';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }
                  ),
                ),
              )
            
            ]
          ),
        ),
      ),
    );
  }
}