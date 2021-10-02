import 'package:flutter/material.dart';
import './bp_screen.dart';
import './wip_screen.dart';

class CreatePartyScreen extends StatelessWidget {
  static const routeName = '/create-party';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose the Occassion:'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'images/party.jpg'), //https://drive.google.com/file/d/1CsA1_fld5FREd7vExNo_evfvI5Ir69v4/view?usp=sharing
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/cake.jpeg', height: 200, width: 200
                //fit: BoxFit.cover,
                ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(BdayPartyScreen.routeName);
                },
                child: Text('Birthday Party', style: TextStyle(fontSize: 20))),
            SizedBox(height: 20),
            Image.asset('assets/images/anni.png', height: 200, width: 200
                //fit: BoxFit.cover,
                ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(wipScreen.routeName);
                },
                child:
                    Text('Anniversary Party', style: TextStyle(fontSize: 20))),
          ],
        )), /* add child content here */
      ),
    );
  }
}
