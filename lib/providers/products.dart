import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './product.dart';
//import '../screens/add_wishes_screen.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
//     // Product(
//     //   id: 'p1',
//     //   title: 'Red Shirt',
//     //   description: 'A red shirt - it is pretty red!',
//     //   price: 29.99,
//     //   imageUrl:
//     //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//     // ),
//     // Product(
//     //   id: 'p2',
//     //   title: 'Trousers',
//     //   description: 'A nice pair of trousers.',
//     //   price: 59.99,
//     //   imageUrl:
//     //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
//     // ),
//     // Product(
//     //   id: 'p3',
//     //   title: 'Yellow Scarf',
//     //   description: 'Warm and cozy - exactly what you need for the winter.',
//     //   price: 19.99,
//     //   imageUrl:
//     //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
//     // ),
//     // Product(
//     //   id: 'p4',
//     //   title: 'A Pan',
//     //   description: 'Prepare any meal you want.',
//     //   price: 49.99,
//     //   imageUrl:
//     //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
//     // ),
  ];
//   // var _showFavoritesOnly = false;
  final String authToken;
  final String userId;

  Products(this.authToken, this.userId, this._items);

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

//   List<Product> get favoriteItems {
//     return _items.where((prodItem) => prodItem.isFavorite).toList();
//   }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

//   // void showFavoritesOnly() {
//   //   _showFavoritesOnly = true;
//   //   notifyListeners();
//   // }

//   // void showAll() {
//   //   _showFavoritesOnly = false;
//   //   notifyListeners();
//   // }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = Uri.https('kiaanshparty-default-rtdb.firebaseio.com',
        '/products.json?auth=$authToken&$filterString');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url = Uri.https('https://rockk-app-default-rtdb.firebaseio.com/',
          '/userFavorites/$userId.json?auth=$authToken');
      //final favoriteResponse = await http.get(url);
      //final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          name: prodData['name'],
          relation: prodData['relation'],
          message: prodData['message'],
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product, var loc) async {
    //final url = Uri.https('kiaanshparty-default-rtdb.firebaseio.com', '/products.json?auth=$authToken');
    final url =
        'https://rockk-playstore-default-rtdb.firebaseio.com/products.json';
    //   'https://kiaanshparty-default-rtdb.firebaseio.com/products.json';
    //'https://rock-kiaansh-default-rtdb.firebaseio.com/wishes.json';
    //;
    //'https://kiaanshparty-default-rtdb.firebaseio.com/products.json?auth=$authToken'; //for auth users
    //'https://kiaanshparty-default-rtdb.firebaseio.com/products/$userId.json?auth=$authToken'; //if user specific items
    //print('tp');
    //print(url);
    try {
      //print(product.name);
      //print('neha3');
      print(loc);
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'name': product.name,
          'relation': product.relation,
          'message': product.message,
          'imageUrl': loc,
          //'price': product.price,
          'creatorId': userId,
        }),
      );
      //print(product.price);
      //print(response.body);
      final resdata = json.decode(response.body);
      print(resdata);
      final newProduct = Product(
        name: product.name,
        relation: product.relation,
        message: product.message,
        imageUrl: loc,
        id: resdata['name'],
      );
      //print(product.description);
      _items.add(newProduct);
      //print(product.price);
      // _items.insert(0, newProduct); // at the start of the list
      // showDialog(
      //   context: context,
      //   builder: (ctx) => AlertDialog(
      //     title: Text('Your wishes sent to Kiaansh!'),
      //     content: Text('Thank You!'),
      //     actions: <Widget>[
      //       TextButton(
      //         child: Text('Okay'),
      //         onPressed: () {
      //           Navigator.of(ctx)
      //               .pushReplacementNamed(AddWishesScreen.routeName);
      //         },
      //       )
      //     ],
      //   ),
      // );
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.https('kiaanshparty-default-rtdb.firebaseio.com',
          '/products/$id.json?auth=$authToken');
      await http.patch(url,
          body: json.encode({
            'name': newProduct.name,
            'relation': newProduct.relation,
            'message': newProduct.message,
            'imageUrl': newProduct.imageUrl,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.https('kiaanshparty-default-rtdb.firebaseio.com',
        '/products/$id.json?auth=$authToken');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
