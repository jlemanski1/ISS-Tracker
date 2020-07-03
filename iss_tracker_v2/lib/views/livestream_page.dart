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

  double _volume = 100;
  bool _muted = true;
  bool _isPlayerReady = false;
  final String _videoId = 'XBPjVzSoepo';

  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController(
    initialVideoId: _videoId,
    flags: const YoutubePlayerFlags(
      mute: true,
      autoPlay: false,
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
        appBar: AppBar(
          backgroundColor: Settings.isLightTheme ? Colors.blueGrey[400] : Colors.black54,
          centerTitle: true,
          title: Text("Earth Live View",
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
              colors: Settings.isLightTheme ? [Colors.blueGrey[400], Colors.pink[200]]
                : [Colors.black87, Colors.black],
            )
          ),
          child: Column(
            children: <Widget>[
              player,
              Padding(padding: EdgeInsets.symmetric(vertical: 4.0),),
              Card(
                color: Colors.transparent,
                child: ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Colors.amberAccent[400],
                  ),
                  title: Text(
                    'HDEV payload reached end-of-life Aug. 22, 2019',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  subtitle: Text(
                    'A continuous feed of past recordings will be shown.',
                    style: TextStyle(
                      color: Colors.blueGrey[200],
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 8.0, bottom: 4.0),),
              Text(
                'Mission Information',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  fontFamily: 'WorkSans'
                )
              ),
              Card(
                color: Colors.transparent,
                child: Column(
                  children: <Widget> [
                    ListTile(
                      title: Text(
                        'The High Definition Earth Viewing (HDEV) investigation places four different commercial'
                        +' high definition cameras external to the ISS on the Columbus External Facility',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
                    ListTile(
                      title: Text(
                        "Validate space-based performance of the cameras in a variety of modes.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      subtitle: Text(
                        "Assessing the hardware's ability to survive and function in the extreme radioactive"
                        +" of Low Earth Orbit (LEO) while taking Earth imagery."
                      ),
                    ),
                  ]
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.web),
                  title: Text('View NASA mission page for more information.'),
                  subtitle: Text(''),
                  onTap: () async {
                    // Navigate to NASA mission page
                    const url = 'https://www.nasa.gov/mission_pages/station/research/experiments/explorer/Investigation.html?#id=892';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  }
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}