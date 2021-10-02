//import 'dart:convert';

import 'package:flutter/foundation.dart';
//import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String relation;
  final String message;
  final String imageUrl;
  // bool isFavorite;

  Product({
    @required this.id,
    @required this.name,
    @required this.relation,
    @required this.message,
    @required this.imageUrl,
    //this.isFavorite = false,
  });
}
