import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
//import '../widgets/app_drawer.dart';
import 'dart:async';
import '../screens/kiaansh_party_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class VideoPlayScreen extends StatelessWidget {
//   static const routeName = '/video';
//   final String videoUrl = '';

//   VideoPlayScreen(this.videoUrl);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Your wishes...'),),
//       drawer: AppDrawer(),
//       body: Center(child: ,),
//     )
//   }
// }

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({
    Key key,
    @required this.videoUrl,
    @required this.wish_from,
    @required this.wish_msg,
  }) : super(key: key);

  static const routeName = '/video';
  final String videoUrl;
  final String wish_from;
  final String wish_msg;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(widget.videoUrl);
    print(_controller);

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(false);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    // print('final');
    // print(videoId);

    // YoutubePlayerController _control = YoutubePlayerController(
    //     initialVideoId: videoId,
    //     flags: YoutubePlayerFlags(
    //         autoPlay: true,
    //         mute: false,
    //         controlsVisibleAtStart: true,
    //         hideControls: false));

    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishes from ${widget.wish_from}'),
        backgroundColor: Colors.deepOrange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_rounded),
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: Colors.red,
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: Stack(
        children: [
          Container(
            height: deviceSize.height,
            width: deviceSize.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.all(10),
          //   child: SingleChildScrollView(
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         YoutubePlayer(
          //           controller: _control,
          //           showVideoProgressIndicator: true,
          //           progressIndicatorColor: Colors.deepOrange,
          //           onReady: () {
          //             print('play video');
          //             //_control.addListener(true);
          //           },
          //         ),
          //         SizedBox(
          //           height: 20,
          //         ),
          //         Container(
          //           //height: deviceSize.height * 0.2,
          //           child: Text(
          //             '"${widget.wish_msg}"',
          //             style: TextStyle(
          //                 fontSize: 30,
          //                 fontWeight: FontWeight.bold,
          //                 fontStyle: FontStyle.italic,
          //                 color: Colors.red),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  // Use the VideoPlayer widget to display the video.
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    //height: deviceSize.height,
                    child: SingleChildScrollView(
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                          // Container(
                          //   //padding: EdgeInsets.all(10),
                          //   height: deviceSize.height * 0.5,
                          //   width: deviceSize.width * 0.8,
                          //   child: VideoPlayer(_controller),
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            //height: deviceSize.height * 0.2,
                            child: Text(
                              '"${widget.wish_msg}"',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.red),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Align(
            alignment: Alignment(0.9, 0.95),
            child: FloatingActionButton(
              onPressed: () {
                // Wrap the play or pause in a call to `setState`. This ensures the
                // correct icon is shown.
                setState(() {
                  // If the video is playing, pause it.
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    // If the video is paused, play it.
                    _controller.play();
                  }
                });
              },
              // Display the correct icon depending on the state of the player.

              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ),
          // Align(
          //     alignment: Alignment(0.9, 0.9),
          //     child: FloatingActionButton(
          //       child: Icon(Icons.arrow_back_rounded),
          //       onPressed: () {
          //         Navigator.of(context).pop();
          //       },
          //       backgroundColor: Colors.red,
          //     )),
        ],
      ),
    );
  }
}
