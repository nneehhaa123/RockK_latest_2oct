import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../screens/kiaansh_party_screen.dart';
//import 'dart:async';
//import 'package:video_player/video_player.dart';

class introScreen extends StatelessWidget {
  //const introScreen({ Key? key }) : super(key: key);
  static const routeName = '/intro-screen';

  // VideoPlayerController _controller;
  // Future<void> _initializeVideoPlayerFuture;
  // @override
  // void initState() {
  //   // Create and store the VideoPlayerController. The VideoPlayerController
  //   // offers several different constructors to play videos from assets, files,
  //   // or the internet.
  //   _controller = VideoPlayerController.asset('assets/dance_kia.mp4');

  //   // Initialize the controller and store the Future for later use.
  //   _initializeVideoPlayerFuture = _controller.initialize();

  //   // Use the controller to loop the video.
  //   _controller.setLooping(true);

  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   // Ensure disposing of the VideoPlayerController to free up resources.
  //   _controller.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          //=> false,
          print('intoback');
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Kiaansh's Introduction"),
            backgroundColor: Colors.deepOrange,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.of(context).pop();
              // .popUntil(ModalRoute.withName(KiaParty.routeName));
            },
            backgroundColor: Colors.red,
          ),
          drawer: AppDrawer(),
          body: Stack(
            children: [
              Container(
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
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/intro.jpg',
                          height: 250, width: double.infinity
                          //fit: BoxFit.cover,
                          ),
                      // FutureBuilder(
                      //   future: _initializeVideoPlayerFuture,
                      //   builder: (context, snapshot) {
                      //     if (snapshot.connectionState == ConnectionState.done) {
                      //       // If the VideoPlayerController has finished initialization, use
                      //       // the data it provides to limit the aspect ratio of the video.
                      //       return AspectRatio(
                      //         aspectRatio: _controller.value.aspectRatio,
                      //         // Use the VideoPlayer widget to display the video.
                      //         child: VideoPlayer(_controller),
                      //       );
                      //     } else {
                      //       // If the VideoPlayerController is still initializing, show a
                      //       // loading spinner.
                      //       return Center(child: CircularProgressIndicator());
                      //     }
                      //   },
                      // ),
// This trailing comma makes auto-formatting nicer for build methods.

                      Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                'Hello Everyone!👋  My Name is KIAANSH GUPTA and I am 1 Year Old. I live with my Baba, Dadi, Papa and Mumma in Bangalore and I am enjoying it very much 😍. ',
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Everyday, I wake up and go to the terrace with Dadi-Baba to do yoga and pranayam. My favorite exercise is ANULOM-VILOM 👃 and I do it many times during the day. I also like doing Pooja 🙏 with Dadi-Baba in the morning and evening. ',
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "My hobbies include dancing, sleeping, crying and doing lots of mischief. Infact, i love dancing so much that i don't sleep till mumma-papa play a few party songs. ",
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Whenever I get bored or hungry, I cry to get attention. Being born in lockdown, I crave to explore the outside world by trying to sneak out of the main gate when no one is looking. Everyone at home are always running to catch me and close the doors. 😂 ",
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'In my free-time, I do video calls with Nani, Bua- Fufaji, Mama-mami, Gungun didi & Mivaan bhaiya. Gungun didi teaches me how to make funny faces and make shouting noises.',
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'I am missing your presence and would love to meet everyone once the situation is better. Till then, I will keep on doing all the masti and share it with all of you. 🤗',
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     // Wrap the play or pause in a call to `setState`. This ensures the
          //     // correct icon is shown.
          //     setState(() {
          //       // If the video is playing, pause it.
          //       if (_controller.value.isPlaying) {
          //         _controller.pause();
          //       } else {
          //         // If the video is paused, play it.
          //         _controller.play();
          //       }
          //     });
          //   },
          //   // Display the correct icon depending on the state of the player.
          //   child: Icon(
          //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          //   ),
          // ),
        ));
  }
}
