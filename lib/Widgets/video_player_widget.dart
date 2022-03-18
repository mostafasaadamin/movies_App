import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:movies/Style/theme.dart' as style;

class VideoPlayerWidget extends StatefulWidget {
  String youtubeKey;
  VideoPlayerWidget({Key key,this.youtubeKey}) : super(key: key);
  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeKey,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }
  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:style.Themes.mainColor ,
      body: Stack(
        children: [
          Center(
            child:YoutubePlayer(controller: _controller,
              showVideoProgressIndicator: true,
            )
          ),
          Positioned(
            right: 10,
              top: 30,
              child: IconButton(icon: Icon(EvaIcons.closeCircleOutline,color: Colors.white,), onPressed: ()
              {
                _controller.dispose();
                Navigator.pop(context);
              })

          )

        ],
      ),
    );
  }
}