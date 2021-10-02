import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../screens/kiaansh_party_screen.dart';
//import 'dart:async';
//import 'package:video_player/video_player.dart';

class UnorderedListItem extends StatelessWidget {
  UnorderedListItem(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("•  ", style: TextStyle(fontSize: 20, color: Colors.black)),
        Expanded(
          child:
              Text(text, style: TextStyle(fontSize: 20, color: Colors.black)),
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

class unfavScreen extends StatelessWidget {
  //const introScreen({ Key? key }) : super(key: key);
  static const routeName = '/unfav-screen';

  final GlobalKey<NavigatorState> navkeys = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('sure'),
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
              child: Text('Yo'),
            )
          ],
        ),
      );
    }

    return WillPopScope(
        // onWillPop: _onBackPressed,
        onWillPop: () async {
          return Navigator.canPop(context);
        },

        //() async => navkeys.currentState.maybePop(),
        //{
        //return !await navigatorKeys[_currentIndex].currentState.maybePop();
        //},
        child: Scaffold(
          appBar: AppBar(
            title: Text("Kiaansh's Dislikes"),
            backgroundColor: Colors.deepOrange,
          ),
          drawer: AppDrawer(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.of(context).pop();
              //.popUntil(ModalRoute.withName(KiaParty.routeName));
            },
            backgroundColor: Colors.red,
          ),
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
                      Image.asset('assets/images/kia.gif',
                          height: 250, width: double.infinity
                          //fit: BoxFit.cover,
                          ),
                      Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                "Things I don't like...🤢🙄😵",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              UnorderedList([
                                'Being alone...👶👻',
                                'Sleeping during Day...🛌❌',
                                'Keeping quiet during Papa-Mumma’s office meetings...😷🤐🤫❌',
                                'Staying indoors...🏡❌🚗✅'
                              ]),
                            ],
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
