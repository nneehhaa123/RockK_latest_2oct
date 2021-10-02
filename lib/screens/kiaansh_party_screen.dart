import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:twinkle_button/twinkle_button.dart';
import '../providers/orders.dart';
import 'package:provider/provider.dart';

class KiaParty extends StatefulWidget {
  static const routeName = '/KiaParty';

  //print('test');

  @override
  _KiaPartyState createState() => _KiaPartyState();
}

final eventTime = DateTime.parse('2021-07-23 18:30:00');

class _KiaPartyState extends State<KiaParty> {
  static const duration = const Duration(seconds: 1);

  int timeDiff = eventTime.difference(DateTime.now()).inSeconds;

  bool isActive = true;
  bool isparty = true;

  Timer timer;

  var _isInit = true;

  //String iniarg;
  var newarg;
  List temp;

  var args;

  // @override //not working as its keep on fetching arg as you switch screens so have to initialize it
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     print('11');
  //     print(_isInit);
  //     final args = ModalRoute.of(context).settings.arguments as String;
  //     print(args);
  //     if (args != null) {
  //       newarg = args;
  //     }
  //   }
  //   _isInit = false;
  //   print('12');
  //   print(_isInit);
  //   super.didChangeDependencies();
  // }

  void handleTick() {
    if (timeDiff > 0) {
      if (isActive) {
        setState(() {
          //if (eventTime != DateTime.now()) {
          if (eventTime.isAfter(DateTime.now())) {
            //print(DateTime.now());
            //print(timeDiff);
            timeDiff = timeDiff - 1;
          } else {
            print('Times up! Please join the party!');
            //isparty = false;
            //Do something
          }
        });
      }
    }
  }

  _launchURL() async {
    const url =
        'https://www.youtube.com/playlist?list=PLiWCkcex5prhTWLWAwU5JY1C6HyAeoPe3';
    // 'https://us05web.zoom.us/j/83774524098?pwd=M0NHa2JyS1ppWHVCOG1SVHJoN3lDQT09';
    //
    await launch(url);
    // 'https://us05web.zoom.us/j/83774524098?pwd=M0NHa2JyS1ppWHVCOG1SVHJoN3lDQT09'; //zoom party link
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  _launcPartyURL() async {
    const Partyurl =
        'https://us02web.zoom.us/j/85912629010?pwd=Y1FxR09jMkd2VEppMVQwMmxXcjFuQT09';

    await launch(Partyurl);
  }

  @override
  void initState() {
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        if (eventTime.isAfter(DateTime.now())) {
          handleTick();
        } else {
          setState(() {
            isparty = false;
          });
        }
      });
    }

    // Future.delayed(Duration.zero, () {
    //   setState(() {
    //     final args = ModalRoute.of(context).settings.arguments as String;
    //     print('105');
    //     print(args);

    //     if (args != null) {
    //       if (args.contains('@')) {
    //         temp = args.split('@');
    //         newarg = temp[0];
    //       } else {
    //         newarg = args;
    //       }
    //     }
    //     print('104');
    //     print(newarg);
    //   });
    // });

    super.initState();
  }

  @override
  void dispose() {
    print(timer);
    if (timer != null) timer.cancel();
    super.dispose();
  }

  // Future<bool> _onBackPressed() {
  //   return showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: Text('sure'),
  //           actions: [
  //             GestureDetector(
  //               onTap: Navigator.of(context).pop(false),
  //               child: Text('No'),
  //             ),
  //             GestureDetector(
  //               onTap: Navigator.of(context).pop(true),
  //               child: Text('Yo'),
  //             )
  //           ],
  //         ),
  //       ) ??
  //       false;
  // }
  Future<bool> onback() async {
    return true;
  }

  var scaffoldkey = GlobalKey<ScaffoldState>(); //to open drawer via button

  @override
  Widget build(BuildContext context) {
    // print(Timer.periodic(duration, (timer) { }));

    int days = timeDiff ~/ (24 * 60 * 60);
    int hours = timeDiff ~/ (60 * 60) % 24;
    int minutes = (timeDiff ~/ 60) % 60;
    int seconds = timeDiff % 60;

    //final newarg = ModalRoute.of(context).settings.arguments as String;

    //print('1033');
    //print(newarg);

    return Scaffold(
      // WillPopScope(
      //   onWillPop: () async => false,
      // onWillPop: () {
      //   print('backbotton pressed');
      //   Navigator.pop(context, false);
      //   return Future.value(false);
      //   // showDialog<bool>(
      //   //   context: context,
      //   //   builder: (c) => AlertDialog(
      //   //         title: Text('sure'),
      //   //         backgroundColor: Colors.black,
      //   //         actions: [
      //   //           GestureDetector(
      //   //             onTap: () => Navigator.pop(c, false),
      //   //             child: Text('No'),
      //   //           ),
      //   //           GestureDetector(
      //   //             onTap: () => Navigator.pop(c, true),
      //   //             child: Text('Yo'),
      //   //           )
      //   //         ],
      //   //       ))
      // }, //async => false, //_onBackPressed,
      //child:
      key: scaffoldkey,
      appBar: AppBar(
        leading: TwinkleButton(
            buttonTitle: Text(
              'Click here',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                //fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
            highlightColor: Colors.white,
            buttonColor: Colors.blue.shade900,
            buttonWidth: 60,
            onclickButtonFunction: () {
              scaffoldkey.currentState.openDrawer();
            }),
        title: Text(
          "Kiaansh's party 🍻",
          //"Welcome $newarg...",
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/beach.gif',
              // Image.network(
              //   'https://drive.google.com/uc?export=view&id=1MSfbwYvJyWN0c00FqaJ6HEjVu58ieu65',
              //'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              "Hola! It's Kiaansh’s 1st Birthday",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Text(
                  'The Magical 23rd July is not far away, ',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'When Little Prince Kiaansh turns ONE. ',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  'Seems like he was born yesterday, ',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'But now he is walking & ready to run. ',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  '   Masked up, in the home we stay, ',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Inviting you for an evening full of fun. ',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  '   Let’s come together and make some hay, ',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'With a cosy party under the virtual Sun. ',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ]),
            ),
            SizedBox(height: 5),
            Text(
              'When - 23rd July 2021, 6:30 PM',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Text(
            //   'Time - 6:30 PM',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            SizedBox(height: 10),
            Text(
              'Countdown begins! ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            isparty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      LabelText(
                          label: 'DAYS',
                          value: days.toString().padLeft(2, '0')),
                      LabelText(
                          label: 'HRS',
                          value: hours.toString().padLeft(2, '0')),
                      LabelText(
                          label: 'MIN',
                          value: minutes.toString().padLeft(2, '0')),
                      LabelText(
                          label: 'SEC',
                          value: seconds.toString().padLeft(2, '0')),
                    ],
                  )
                : Text("Yay!!! It's Party time..🎉💃",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange)),
            SizedBox(
              height: 10,
            ),
            TwinkleButton(
                buttonTitle: Text(
                  '⏩ See my memories ⏩',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                buttonColor: Colors.deepOrange,
                buttonWidth: 220,
                buttonHeight: 35,
                onclickButtonFunction: _launchURL),

            SizedBox(
              height: 20,
            ),
            TwinkleButton(
                buttonTitle: Text(
                  'Join Party...🎉💃',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                buttonColor: Colors.blue.shade900,
                buttonWidth: 200,
                buttonHeight: 35,
                onclickButtonFunction: _launcPartyURL),
            // ElevatedButton(
            //   onPressed: _launchURL,
            //   child: Text('Join party', style: TextStyle(fontSize: 15)),
            //   style:
            //       ElevatedButton.styleFrom(primary: Colors.yellow.shade900),
            // )
          ],
        )),
      ),

      // )
    );
  }
}

class LabelText extends StatelessWidget {
  LabelText({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.yellow.shade900,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
