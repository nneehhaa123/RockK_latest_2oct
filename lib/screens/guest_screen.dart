import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/guest.dart';

import 'dart:async';

import 'package:flutter/widgets.dart';

class GuestScreen extends StatefulWidget {
  // const GuestScreen({
  //   Key key,
  //   @required this.allRoute,
  // }) : super(key: key);

  static const routeName = '/guest';

  //final allRoute;

  @override
  _GuestScreenState createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  final _loginform = GlobalKey<FormState>();
  String device_name;
  var _isLoading = false;

  Future<void> _guestsubmit() async {
    final isValid = _loginform.currentState.validate();
    if (!isValid) {
      return;
    }
    _loginform.currentState.save();
    setState(() {
      _isLoading = true;
    });
    print('1');
    print(device_name);
    //login screen and save device name somewhere
    await Provider.of<Guest>(context, listen: false).Guestlogin(device_name);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      backgroundColor: Colors.white,
      child: Container(
          height: deviceSize.height * 0.3,
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _loginform,
            child: Column(
              children: [
                TextFormField(
                  //initialValue: _initValues['name'],
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  decoration: InputDecoration(
                    labelText: 'Please enter your name:',
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    device_name = value;
                  },
                ),
                SizedBox(
                  height: deviceSize.height * 0.1,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: _guestsubmit,
                      style: TextButton.styleFrom(
                          primary: Colors.deepOrange,
                          backgroundColor: Colors.deepOrange),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          )),
    );
  }
}
