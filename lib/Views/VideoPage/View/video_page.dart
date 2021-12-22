import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  String videoID;

  VideoPage({Key? key, required this.videoID}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(initialVideoId: widget.videoID, flags: YoutubePlayerFlags(autoPlay: false));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38.withOpacity(0.5),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(onTap: (() => Navigator.pop(context))),
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressColors: ProgressBarColors(playedColor: Colors.amber, handleColor: Colors.amber),
            onReady: () {
            },
            onEnded: (_){
              // DeviceOrientation.landscapeLeft;
            },
          ),
        ],
      ),
    );
  }
}
