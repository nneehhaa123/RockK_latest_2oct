//import 'dart:html';

import 'package:flutter/material.dart';
import './kiaansh_party_screen.dart';
import './create_party_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/ProdOver';

  const ProductsOverviewScreen({
    Key key,
    @required this.uname,
  }) : super(key: key);

  final String uname;

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  final _codeform = GlobalKey<FormState>();
  String party_code = '';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    //final parg = ModalRoute.of(context).settings.arguments as String;

    print('102');
    print(widget.uname);

    return Scaffold(
        appBar: AppBar(
          title: Text('Join a Party or Create One!'),
          backgroundColor: Colors.deepOrange,
          actions: [
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  //Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/');
                  Provider.of<Auth>(context, listen: false).logout();
                })
          ],
        ),
        //drawer: AppDrawer(),
        body: Form(
          key: _codeform,
          child: Stack(
            children: <Widget>[
              Container(
                height: deviceSize.height,
                width: deviceSize.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("images/p14.jpg"),
                  ),
                ),
              ),
              SingleChildScrollView(
                //to avoid overflow issue
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: deviceSize.height * 0.4),
                      Text(
                        'Already have a party code?',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        //initialValue: _initValues['mlno'],
                        decoration: InputDecoration(
                            labelText: 'Enter party code',
                            border: OutlineInputBorder()),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid code';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          print(value);
                          party_code = value;
                        },
                      ),
                      ElevatedButton(
                          child: Text(
                            'Join Party',
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange),
                          onPressed: () {
                            final isValid = _codeform.currentState.validate();
                            if (!isValid) {
                              return;
                            }
                            _codeform.currentState.save();
                            //party_code.isEmpty
                            if (party_code != '2307') {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text('An error occurred!'),
                                  content:
                                      Text('Please enter the correct code!'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Okay'),
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                    )
                                  ],
                                ),
                              );
                            } else {
                              //Text('Please enter the correct code')
                              Navigator.of(context).pushNamed(
                                  KiaParty.routeName,
                                  arguments: widget.uname);
                              // Navigator.of(context).pushAndRemoveUntil(
                              //     MaterialPageRoute(
                              //         builder: (context) => KiaParty()),
                              //     (route) => false);
                            }
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'OR',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Create your own party...',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          child: Text('Create Party',
                              style: TextStyle(fontSize: 20)),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(CreatePartyScreen.routeName);
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
