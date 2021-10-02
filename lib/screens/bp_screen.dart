import 'package:flutter/material.dart';
import './ML_form_screen.dart';
import './wip_screen.dart';

class BdayPartyScreen extends StatelessWidget {
  static const routeName = '/bday-party';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set up Birthday Party...'),
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
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(MLformScreen.routeName);
                },
                child: Text('Add Milestones', style: TextStyle(fontSize: 20))),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(wipScreen.routeName);
                },
                child:
                    Text('Create Zoom call', style: TextStyle(fontSize: 20))),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(wipScreen.routeName);
                },
                child: Text("Create Party Member's Group",
                    style: TextStyle(fontSize: 20))),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(wipScreen.routeName);
                },
                child: Text('Send Meeting Invite',
                    style: TextStyle(fontSize: 20))),
          ],
        )), /* add child content here */
      ),
    );
  }
}
