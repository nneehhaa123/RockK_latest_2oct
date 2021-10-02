import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'dart:io';

class EnterCodeScreen extends StatefulWidget {
  static const routeName = '/enterCode';

  @override
  _EnterCodeScreenState createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  final _codeform = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  String partyCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Please enter the party code!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _codeform,
          child: TextFormField(
            //initialValue: _initValues['mlno'],
            decoration:
                InputDecoration(labelText: 'Please enter the party code!'),
            textInputAction: TextInputAction.next,
            //keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please provide a value.';
              }
              return null;
            },
            onSaved: (value) {
              print(value);
              partyCode = value;
            },
          ),
        ),
      ),
    );
  }
}
