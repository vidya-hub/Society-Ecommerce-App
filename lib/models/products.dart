

import 'package:flutter/material.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Mango',
      description: 'A Devgad HApus Mango!',
      price: 29.99,
      imageUrl:
          'https://calories-info.com/site/assets/files/1173/mango.650x0.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Boutique',
      description: 'Desginers and trending collection available',
      price: 59.99,
      imageUrl: 'https://imgstaticcontent.lbb.in/lbbnew/wp-content/uploads/sites/2/2016/09/Anahe-f.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Perfume',
      description: 'A wild Freshness - good for daily use',
      price: 99.99,
      imageUrl:
          'https://staticimg.titan.co.in/Skinn/Catalog/FW04PFL_2.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
  // var _showFavoritesOnly = false;

  // final String authToken;
  // final String userId;

  // Products(this.authToken,this.userId, this._items);

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }


  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  // Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
  //   final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
  //   var url = 'https://shopappflutter-8ca5f.firebaseio.com/products.json?auth=$authToken&$filterString';
  //   try {
  //     final response = await http.get(url);
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     if (extractedData == null) {
  //       return;
  //     }
  //     url = 'https://shopappflutter-8ca5f.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
  //     final favoriteResponse = await http.get(url);
  //     final favoriteData = json.decode(favoriteResponse.body);
  //     final List<Product> loadedProducts = [];
  //     extractedData.forEach((prodId, prodData) {
  //       loadedProducts.add(Product(
  //         id: prodId,
  //         title: prodData['title'],
  //         description: prodData['description'],
  //         price: prodData['price'],
  //         isFavorite: favoriteData == null ? false : favoriteData[prodId] ?? false,
  //         imageUrl: prodData['imageUrl'],
  //       ));
  //     });
  //     _items = loadedProducts;
  //     notifyListeners();
  //   } catch (error) {
  //     throw (error);
  //   }
  // }

  Future<void> addProduct(Product product) async {
   // _items.add(value);
    // final url = 'https://shopappflutter-8ca5f.firebaseio.com/products.json?auth=$authToken';
    // try {
    //   final response = await http.post(
    //     url,
    //     body: json.encode({
    //       'title': product.title,
    //       'description': product.description,
    //       'imageUrl': product.imageUrl,
    //       'price': product.price,
    //       'creatorId': userId,
    //     }),
    //   );
    //   final newProduct = Product(
    //     title: product.title,
    //     description: product.description,
    //     price: product.price,
    //     imageUrl: product.imageUrl,
    //     id: json.decode(response.body)['name'],
    //   );
    //   _items.add(newProduct);
    //   // _items.insert(0, newProduct); // at the start of the list
    //   notifyListeners();
    // } catch (error) {
    //   print(error);
    //   throw error;
    // }
  }

  // Future<void> updateProduct(String id, Product newProduct) async {
  //   final prodIndex = _items.indexWhere((prod) => prod.id == id);
  //   if (prodIndex >= 0) {
  //     final url = 'https://shopappflutter-8ca5f.firebaseio.com/products/$id.json?auth=$authToken';
  //     await http.patch(url,
  //         body: json.encode({
  //           'title': newProduct.title,
  //           'description': newProduct.description,
  //           'imageUrl': newProduct.imageUrl,
  //           'price': newProduct.price
  //         }));
  //     _items[prodIndex] = newProduct;
  //     notifyListeners();
  //   } else {
  //     print('...');
  //   }
  // }

  // Future<void> deleteProduct(String id) async {
  //   final url = 'https://shopappflutter-8ca5f.firebaseio.com/products/$id.json?auth=$authToken';
  //   final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
  //   var existingProduct = _items[existingProductIndex];
  //   _items.removeAt(existingProductIndex);
  //   notifyListeners();
  //   final response = await http.delete(url);
  //   if (response.statusCode >= 400) {
  //     _items.insert(existingProductIndex, existingProduct);
  //     notifyListeners();
  //     throw HttpException('Could not delete product.');
  //   }
  //   existingProduct = null;
  // }
}