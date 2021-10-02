import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:twinkle_button/twinkle_button.dart';

class UnorderedListItem extends StatelessWidget {
  UnorderedListItem(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("•  ", style: TextStyle(fontSize: 17, color: Colors.black)),
        Expanded(
          child:
              Text(text, style: TextStyle(fontSize: 17, color: Colors.black)),
        ),
      ],
    );
  }
}

class UnorderedList extends StatelessWidget {
  UnorderedList(this.texts);
  final List<String> texts;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (var text in texts) {
      // Add list item
      widgetList.add(UnorderedListItem(text));
      // Add space between items
      widgetList.add(SizedBox(height: 10.0));
    }

    return Column(children: widgetList);
  }
}

class UseScreen extends StatelessWidget {
  //const UseScreen({ Key? key }) : super(key: key);
  static const routeName = '/use-screen';

  _launchtutURL() async {
    const tuturl =
        'https://youtube.com/playlist?list=PLiWCkcex5prjc-AEPRwT9-vngaBCiQYUC';
    await launch(tuturl);
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Back to Home screen?'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Yes'),
            )
          ],
        ),
      );
    }

    final deviceSize = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          //  WillPopScope(
          //   onWillPop: () async => false,
          //   child:
          appBar: AppBar(
              title: Text(
            'How to use RockK',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  height: deviceSize.height,
                  width: deviceSize.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("images/p13.jpg"),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //crossAxisAlignment: CrossAxisAlignment.s,
                    children: <Widget>[
                      SizedBox(height: deviceSize.height * 0.35),
                      Text(
                        'RockK app is super easy. You can create your party and invite your loved ones & join parties in just a few seconds. ',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Create a Party:',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 20),
                      UnorderedList([
                        'Name your Party e.g. “Kiaansh’s 1st Birthday”',
                        'Add milestones with photos & details to your Party',
                        'Share Party Code with friends & family',
                        'Start Video Party and cherish the memories'
                      ]),
                      SizedBox(height: 30),
                      Text(
                        'Join a Party:',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 20),
                      UnorderedList([
                        'Enter Party Code',
                        'Send wishes & see others’ wishes',
                        'Join Video Party and have a balst'
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      TwinkleButton(
                          buttonTitle: Text(
                            'Watch Tutorial',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          buttonColor: Colors.deepOrange,
                          buttonWidth: 220,
                          buttonHeight: 35,
                          onclickButtonFunction: _launchtutURL),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
