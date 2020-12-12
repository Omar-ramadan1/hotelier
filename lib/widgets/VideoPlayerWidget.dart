import 'package:flutter/material.dart';
import 'package:hotelier/screens/Contact.dart';
import 'package:video_player/video_player.dart';
class VideoPlayerWidget extends StatefulWidget {
  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

 print(_controller.value);
    return Stack(
      children: [
        Container(
          width: 500,
          child: _controller.value.initialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(),
        ),
        Positioned(
          width: 250,
          height: 20,
          bottom: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                      _controller.seekTo(Duration(seconds: 0));
                      _controller.play();
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  child:   Icon(Icons.settings_backup_restore),
                ),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    if(_controller.value.position < Duration(seconds: 11)){
                      _controller.seekTo(Duration(seconds: 0));
                    }else{
                      _controller.seekTo(_controller.value.position - Duration(seconds: 10));
                    }

                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 30),
                  child:   Icon(Icons.arrow_back_sharp),
                ),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 30),
                    child:  _controller.value.isPlaying ? Icon(Icons.pause_circle_outline) : Icon(Icons.not_started_outlined),
                ),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    _controller.seekTo(_controller.value.position + Duration(seconds: 10));
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 40),
                  child: Icon(Icons.arrow_forward),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

