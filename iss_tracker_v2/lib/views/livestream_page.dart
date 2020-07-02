import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iss_tracker_v2/components/settings.dart';
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
                      color: Colors.blueGrey[300],
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.start,
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