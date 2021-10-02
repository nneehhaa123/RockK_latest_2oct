import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../screens/login_screen.dart';
//import 'dart:io';
import '../widgets/custom_dialogue.dart';

import '../screens/how_use_screen.dart';
import '../screens/milestone_screen.dart';

class FirstPage extends StatefulWidget {
  static const routeName = '/first-page';

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String messageTitle = "Empty";
  String notificationAlert = "alert";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      FirebaseMessaging messaging;

      messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) {
        print('neha');
        print(value);
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage event) {
        print("message recieved");
        print(event.notification.body);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(event.notification.title),
                content: Text(event.notification.body),
                actions: [
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (BuildContext context) {
                      //   return MLScreen();
                      // }));
                      //Navigator.of(context).pushNamed(MLScreen.routeName);
                    },
                  )
                ],
              );
            });
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      print('A new onMessageOpenedApp event was published!');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(event.notification.title),
              content: Text(event.notification.body),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigator.of(context).push( //othrt screen not working as routes are not defined if we open directly
                    //     MaterialPageRoute(builder: (BuildContext context) {
                    //   return MLScreen();
                    // }));
                    //Navigator.of(context).pushNamed(MLScreen.routeName);
                  },
                )
              ],
            );
          });
    });
  }
  // Future<void> _messageHandler(RemoteMessage message) async {
  //   print('background message ${message.notification.body}');
  // }

  // void main() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  //   FirebaseMessaging.onBackgroundMessage(_messageHandler);
  //   runApp(FirstPage());
  // }

  // FirebaseMessaging.onMessageOpenedApp.listen((message) {
  //   print('Message clicked!');
  // });

  Widget build(BuildContext context) {
    //timeDilation = 5.0; // 1.0 means normal animation speed.
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '     Welcome to RockK App!',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
          textAlign: TextAlign.left,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: deviceSize.height,
            width: deviceSize.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("images/front.jpg"),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // SizedBox(
                  //   height: deviceSize.height * 0.20,
                  // ),
                  Container(
                    width: deviceSize.width,
                    //height: deviceSize.height * 0.25,
                    //margin: EdgeInsets.only(bottom: 20.0),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: deviceSize.height * 0.10),
                        Text(
                          '“RockK - Rocking Kiaansh’s” App!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: deviceSize.height * 0.1,
                        ),
                        // Text(
                        //   'This app is dedicated to the most amazing family and friends around the world.',
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //       fontSize: 23,
                        //       fontWeight: FontWeight.normal,
                        //       color: Colors.white),
                        // ),
                        // SizedBox(
                        //   height: 30,
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: deviceSize.height * 0.35,
                    width: deviceSize.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        //fit: BoxFit.fill,
                        image: AssetImage("images/kia_rock.jpg"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.05,
                  ),
                  Text(
                    'Let’s Connect & Party in the Rocking way!!!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),

                  SizedBox(
                    height: deviceSize.height * 0.07,
                  ),
                  Container(
                    width: deviceSize.width,
                    height: deviceSize.height * 0.10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.yellow.shade900,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.white,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return CustomDialogBox(
                                  title: 'What is "RockK"?',
                                  descriptions:
                                      '"RockK" is our effort to celebrate Kiaansh’s birthday with our loved ones, our rocking family members and friends from the comfort and safety of home. RockK ke sath celebrate kare saari khushiyaan. Kabhi bhi Kahin bhi! Humara apna Party App - RockK App!',
                                  text: 'OK',
                                  img: 'images/p12.jpg',
                                );
                              }));
                            },
                            icon: Icon(
                              Icons.info,
                              size: 40,
                              color: Colors.black,
                            ),
                            label: Text('Info')),
                        ElevatedButton.icon(
                            icon: Icon(Icons.assignment_rounded,
                                size: 40, color: Colors.black),
                            label: Text('Tips'),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return UseScreen();
                              }));
                            }),
                        ElevatedButton.icon(
                            icon: Icon(
                              Icons.login,
                              size: 40,
                              color: Colors.black,
                            ),
                            label: Text('Login'),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return LoginPage();
                              }));
                            }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
