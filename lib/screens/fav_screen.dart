import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../screens/kiaansh_party_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:twinkle_button/twinkle_button.dart';
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

class favScreen extends StatelessWidget {
  //const introScreen({ Key? key }) : super(key: key);
  static const routeName = '/fav-screen';

  _launchantURL() async {
    const partanturl =
        'https://youtube.com/playlist?list=PLiWCkcex5prjuQLGwSzkdd5CVG06qGBAt';
    await launch(partanturl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kiaansh's Favourites"),
        backgroundColor: Colors.deepOrange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_rounded),
        onPressed: () {
          Navigator.of(context).pop();
          //.popUntil(ModalRoute.withName(KiaParty.routeName));
        },
        backgroundColor: Colors.red,
      ),
      drawer: AppDrawer(),
      body: Stack(children: [
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
                Image.asset('assets/images/kia_dance.gif',
                    height: 250, width: double.infinity
                    //fit: BoxFit.cover,
                    ),
                Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Things I like most...💞💝💗',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        UnorderedList([
                          'Song - Daddy Cool 🤵😎',
                          'Band - 🤘 Coldplay 🤘',
                          'Food - Icecream!!!🍧. Also, anything lying on ground 😛',
                          'Poem(English) - Johny Johny 📖',
                          'Poem(Hindi) - Machli Jal ki Rani 🐬',
                          'Bhajan - Nagari ho Ayodhya si 🙏',
                          'Toy - Anything that can break (Glass items, pots, etc.) 🔮💎',
                          'Passtime - Shouting on office zoom calls 😜'
                        ]),
                        SizedBox(height: 10),
                        Text(
                          'Checkout my party anthems & get grooving 🕺',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        TwinkleButton(
                            buttonTitle: Text(
                              "Kiaansh's Playlist",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            buttonColor: Colors.deepOrange,
                            buttonWidth: 220,
                            buttonHeight: 35,
                            onclickButtonFunction: _launchantURL),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
