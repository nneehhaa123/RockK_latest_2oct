import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final String name;
  final String relation;
  final String message;
  final String imageUrl;

  OrderItem({
    @required this.id,
    @required this.name,
    @required this.relation,
    @required this.message,
    @required this.imageUrl,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    //final filterString = 'orderBy="creatorId"&equalTo="$userId"';
    print(authToken);
    print(userId);
    final url =
        'https://rockk-playstore-default-rtdb.firebaseio.com/products.json';
    //   'https://kiaanshparty-default-rtdb.firebaseio.com/products.json';
    //'https://rock-kiaansh-default-rtdb.firebaseio.com/wishes.json';
    //;
    //'https://kiaanshparty-default-rtdb.firebaseio.com/products.json?auth=$authToken'; //for authenticated users
    //'https://kiaanshparty-default-rtdb.firebaseio.com/products/$userId.json?auth=$authToken';
    //'https://kiaanshparty-default-rtdb.firebaseio.com/products.json?auth=$authToken&orderBy="creatorId"&equalTo="$userId"'; //user specific
    print(url);
    final response = await http.get(Uri.parse(url));
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    print(extractedData);
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          name: orderData['name'],
          relation: orderData['relation'],
          message: orderData['message'],
          imageUrl: orderData['imageUrl'],
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  // Future<void> addOrder(List<CartItem> cartProducts, double total) async {
  //   final url = Uri.https('kiaanshparty-default-rtdb.firebaseio.com',
  //       '/orders/$userId.json?auth=$authToken');
  //   final timestamp = DateTime.now();
  //   final response = await http.post(
  //     url,
  //     body: json.encode({
  //       'amount': total,
  //       'dateTime': timestamp.toIso8601String(),
  //       'products': cartProducts
  //           .map((cp) => {
  //                 'id': cp.id,
  //                 'title': cp.title,
  //                 'quantity': cp.quantity,
  //                 'price': cp.price,
  //               })
  //           .toList(),
  //     }),
  //   );
  //   _orders.insert(
  //     0,
  //     OrderItem(
  //       id: json.decode(response.body)['name'],
  //       amount: total,
  //       dateTime: timestamp,
  //       products: cartProducts,
  //     ),
  //   );
  //   notifyListeners();
  // }
}
