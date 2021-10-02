//import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

import '../providers/milestone.dart' as mlo;
//import 'package:image_picker/image_picker.dart';
//import 'package:video_player/video_player.dart';
//import '../screens/video_play_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MlItem extends StatefulWidget {
  final mlo.MLItem mli;

  MlItem(this.mli);

  @override
  _MlItemState createState() => _MlItemState();
}

class _MlItemState extends State<MlItem> {
  //var _expanded = false;
  //VideoPlayerController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   print('widget.order.imageUrl');
  //   _controller = VideoPlayerController.network(widget.mli.imageUrl)
  //     ..initialize().then((_) {
  //       setState(() {}); //when your thumbnail will show.
  //     });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Milestone No #${widget.mli.mlno}'),
            subtitle: Text('${widget.mli.message}'),
            leading: Image.network(widget.mli.mUrl[0]),
            // _controller.value.isInitialized
            //     ? Container(
            //         width: 70.0,
            //         height: 56.0,
            //         child: VideoPlayer(_controller),
            //       )
            //     : CircularProgressIndicator(),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Scaffold(
                    appBar: AppBar(
                      title: Text('Milestone No #${widget.mli.mlno}'),
                      backgroundColor: Colors.deepOrange,
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.endFloat,
                    floatingActionButton: FloatingActionButton(
                      child: Icon(Icons.arrow_back_rounded),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      backgroundColor: Colors.red,
                    ),
                    body: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(215, 117, 255, 1)
                                    .withOpacity(0.5),
                                Color.fromRGBO(255, 188, 117, 1)
                                    .withOpacity(0.9),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0, 1],
                            ),
                          ),
                        ),
                        Container(
                          //SingleChildScrollView
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Container(
                                height: deviceSize.height * 0.2,
                                child: Text(
                                  '"${widget.mli.message}"',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.red),
                                ),
                              ),
                              SizedBox(
                                height: deviceSize.height * 0.01,
                              ),
                              Container(
                                //height: deviceSize.height * 0.6,
                                child: CarouselSlider.builder(
                                    itemCount: widget.mli.mUrl.length,
                                    options: CarouselOptions(
                                        height: deviceSize.height * 0.65,
                                        enlargeCenterPage: true,
                                        autoPlayInterval: Duration(seconds: 2),
                                        // enlargeStrategy:
                                        //     CenterPageEnlargeStrategy.scale,
                                        autoPlay: true),
                                    itemBuilder: (ctx, i, realIdx) {
                                      return GestureDetector(
                                        child: Container(
                                          //height: deviceSize.height,
                                          child: Image.network(
                                            widget.mli.mUrl[i],
                                            //fit: BoxFit.cover,
                                          ),
                                          //footer: Text('image desc'),
                                        ),
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return Scaffold(
                                              floatingActionButtonLocation:
                                                  FloatingActionButtonLocation
                                                      .endFloat,
                                              floatingActionButton:
                                                  FloatingActionButton(
                                                child: Icon(
                                                    Icons.arrow_back_rounded),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                backgroundColor: Colors.red,
                                              ),
                                              body: Stack(children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color.fromRGBO(215, 117,
                                                                255, 1)
                                                            .withOpacity(0.5),
                                                        Color.fromRGBO(255, 188,
                                                                117, 1)
                                                            .withOpacity(0.9),
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                      stops: [0, 1],
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  child: Center(
                                                    child: Hero(
                                                        child: Image.network(
                                                            widget.mli.mUrl[i]),
                                                        tag: 'imageHero'),
                                                  ),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                )
                                              ]),
                                            );
                                          }));
                                        },
                                      );
                                    }),
                                // GridView.builder(
                                //     itemCount: widget.mli.mUrl.length,
                                //     gridDelegate:
                                //         SliverGridDelegateWithFixedCrossAxisCount(
                                //             crossAxisCount:
                                //                 (Orientation == Orientation.portrait
                                //                     ? 2
                                //                     : 3)),
                                //     itemBuilder: (ctx, i) {
                                //       return GestureDetector(
                                //         child: GridTile(
                                //           child: Image.network(widget.mli.mUrl[i]),
                                //           //footer: Text('image desc'),
                                //         ),
                                //         onTap: () {
                                //           Navigator.push(context,
                                //               MaterialPageRoute(builder: (context) {
                                //             return Scaffold(
                                //               floatingActionButtonLocation:
                                //                   FloatingActionButtonLocation
                                //                       .endFloat,
                                //               floatingActionButton:
                                //                   FloatingActionButton(
                                //                 child:
                                //                     Icon(Icons.arrow_back_rounded),
                                //                 onPressed: () {
                                //                   Navigator.of(context).pop();
                                //                 },
                                //                 backgroundColor: Colors.red,
                                //               ),
                                //               body: GestureDetector(
                                //                 child: Center(
                                //                   child: Hero(
                                //                       child: Image.network(
                                //                           widget.mli.mUrl[i]),
                                //                       tag: 'imageHero'),
                                //                 ),
                                //                 onTap: () {
                                //                   Navigator.pop(context);
                                //                 },
                                //               ),
                                //             );
                                //           }));
                                //         },
                                //       );
                                //     }),
                              )
                            ],
                          ),
                        )
                      ],
                    ));
              }));

              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => VideoPlayerScreen(
              //             videoUrl: widget.order.imageUrl,
              //             wish_from: widget.order.name)));
            },
          ),
        ],
      ),
    );
  }
}
