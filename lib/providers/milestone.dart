import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class MLItem {
  final String id;
  final int mlno;
  final String message;
  final List<dynamic> mUrl;
  final String isVideo;

  MLItem({
    @required this.id,
    @required this.mlno,
    @required this.message,
    @required this.mUrl,
    @required this.isVideo,
  });
}

class Milestone with ChangeNotifier {
  List<MLItem> _ml = [];
  final String authToken;
  final String userId;

  Milestone(this.authToken, this.userId, this._ml);

  List<MLItem> get ml {
    return [..._ml];
  }

  MLItem findById(String id) {
    return _ml.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetMls() async {
    // final filterString =
    //     'orderBy="creatorId"&equalTo="$userId"'; //filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : ''; ?orderBy="height"&startAt=3&print=pretty
    final url =
        'https://rockk-playstore-default-rtdb.firebaseio.com/milestones.json';
    // 'https://kiaanshparty-default-rtdb.firebaseio.com/milestones.json';
    // 'https://rock-kiaansh-default-rtdb.firebaseio.com/milestones.json';
    // ;
    //'https://kiaanshparty-default-rtdb.firebaseio.com/milestones/$userId.json?auth=$authToken';
    //'https://kiaanshparty-default-rtdb.firebaseio.com/milestones.json?auth=$authToken&$filterString';
    final response = await http.get(Uri.parse(url));
    final List<MLItem> loadedMls = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    print(extractedData);
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedMls.add(
        MLItem(
          id: orderId,
          mlno: orderData['mlno'],
          message: orderData['message'],
          mUrl: orderData['mUrl'],
          isVideo: orderData['isVideo'],
        ),
      );
    });
    //_ml = loadedMls.reversed.toList();
    _ml = loadedMls;
    notifyListeners();
  }

  Future<void> addProduct(MLItem product, List<String> mloc) async {
    //final url = Uri.https('kiaanshparty-default-rtdb.firebaseio.com', '/products.json?auth=$authToken');
    final url =
        'https://rockk-playstore-default-rtdb.firebaseio.com/milestones.json';
    // 'https://kiaanshparty-default-rtdb.firebaseio.com/milestones.json';
    // 'https://rock-kiaansh-default-rtdb.firebaseio.com/milestones.json';
    //'
    // 'https://kiaanshparty-default-rtdb.firebaseio.com/milestones.json?auth=$authToken';
    //'https://kiaanshparty-default-rtdb.firebaseio.com/milestones/$userId.json?auth=$authToken';
    //print(url);

    print(mloc.length);
    if (mloc.length == 0) {
      //print('tt');
      mloc = ['null_entry'];
    }
    try {
      //print(product.name);
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'mlno': product.mlno,
          'message': product.message,
          'mUrl': mloc,
          'isVideo': product.isVideo,
          'creatorId': userId,
        }),
      );
      //print(product.price);
      //print(response.body);
      final resdata = json.decode(response.body);
      print(resdata);
      final newProduct = MLItem(
          id: resdata['name'],
          mlno: product.mlno,
          message: product.message,
          mUrl: mloc,
          isVideo: product.isVideo);
      //print(product.description);
      _ml.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, MLItem newProduct) async {
    final prodIndex = _ml.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.https('kiaanshparty-default-rtdb.firebaseio.com',
          '/milestones/$id.json?auth=$authToken');
      await http.patch(url,
          body: json.encode({
            'mlno': newProduct.mlno,
            'message': newProduct.message,
            'mUrl': newProduct.mUrl,
            'isVideo': newProduct.isVideo,
          }));
      _ml[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }
}
