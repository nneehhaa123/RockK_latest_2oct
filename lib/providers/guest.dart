import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Guest with ChangeNotifier {
  String _device_name;

  bool get isGuest {
    return device_name != null;
  }

  String get device_name {
    return _device_name;
  }

  Future<void> Guestlogin(String deviceName) async {
    print('2');
    print(deviceName);

    notifyListeners();
    final gprefs = await SharedPreferences.getInstance();
    final guestData = json.encode(
      {
        'name': deviceName,
      },
    );
    gprefs.setString('guestData', guestData);
  }

  Future<bool> tryGuestLogin() async {
    final gprefs = await SharedPreferences.getInstance();
    if (!gprefs.containsKey('guestData')) {
      return false;
    }
    final extractedGuestData =
        json.decode(gprefs.getString('guestData')) as Map<String, Object>;

    _device_name = extractedGuestData['name'];
    notifyListeners();
    return true;
  }
}
