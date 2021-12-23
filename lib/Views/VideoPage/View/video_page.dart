import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamepedia/Core/Extensions/context_extensions.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  String videoID;

  VideoPage({Key? key, required this.videoID}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late YoutubePlayerController _controller;
  late YoutubePlayer _player;


  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoID,
      flags: YoutubePlayerFlags(autoPlay: false,forceHD: true),
    );
    _player = YoutubePlayer(controller: _controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        if(_controller.value.isFullScreen){
          _controller.toggleFullScreenMode();
        }

        return true;
      },
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor.withOpacity(0.9),
        body: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(onTap: (() => Navigator.pop(context))),
            Hero(
              tag: widget.videoID,
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressColors: ProgressBarColors(playedColor: Colors.amber, handleColor: Colors.amber),
                onReady: () {
                },
                onEnded: (_){
                  // DeviceOrientation.landscapeLeft;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
