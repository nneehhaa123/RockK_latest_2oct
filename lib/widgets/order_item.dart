//import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

import '../providers/orders.dart' as ord;
//import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../screens/video_play_screen.dart';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  //var _expanded = false;
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    //print('widget.order.imageUrl');
    _controller = VideoPlayerController.network(widget.order.imageUrl)
      ..initialize().then((_) {
        setState(() {}); //when your thumbnail will show.
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
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('${widget.order.message}'),
            subtitle:
                Text('From: ${widget.order.name} [${widget.order.relation}]'),
            leading: _controller.value.isInitialized
                ? Container(
                    width: 70.0,
                    height: 56.0,
                    child: VideoPlayer(_controller),
                  )
                : CircularProgressIndicator(),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoPlayerScreen(
                          videoUrl: widget.order.imageUrl,
                          wish_from: widget.order.name,
                          wish_msg: widget.order.message)));
            },
          ),
        ],
      ),
    );
  }
}
