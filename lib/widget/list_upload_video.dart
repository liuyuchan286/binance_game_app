import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



class ListUploadVideo extends StatefulWidget {

  String videoUrl;

  ListUploadVideo({Key key,this.videoUrl}) : super(key: key);

  @override
  _ListUploadVideoState createState() => _ListUploadVideoState();
}

class _ListUploadVideoState extends State<ListUploadVideo> {

  VideoPlayerController _videoPlayerController;
  bool startedPlaying = false;

  @override
  void dispose() {
    _videoPlayerController.pause();
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<bool> started() async {
    await _videoPlayerController.initialize();
    return true;
  }

  @override
  void initState() {
    super.initState();
    print("widget.videoUrl = ${widget.videoUrl}");
    _videoPlayerController =
        VideoPlayerController.network(widget.videoUrl);
  }

  @override
  Widget build(BuildContext context) {
    if(widget.videoUrl != _videoPlayerController.dataSource) {
      _videoPlayerController.pause();
      _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    }

    return FutureBuilder<bool>(
      future: started(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        print(snapshot.data);
        if (snapshot.data == true) {
          return GestureDetector(
            onTap: () async {
              if(startedPlaying) {
                await _videoPlayerController.pause();
              }else {
                await _videoPlayerController.play();
              }
              startedPlaying = !startedPlaying;
            },
            child: VideoPlayer(_videoPlayerController),
          );
        } else {
          return CupertinoActivityIndicator();
        }
      },
    );
  }
}
