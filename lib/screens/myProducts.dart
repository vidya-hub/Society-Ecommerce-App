import 'package:flutter/material.dart';
import '../utils/products_grid.dart';
import 'package:provider/provider.dart';
import '../models/products.dart';

class MyProducts extends StatefulWidget {
  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  @override
  Widget build(BuildContext context) {
    //final orientation = MediaQuery.of(context).orientation;
    final productsData = Provider.of<Products>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Shweta\'s Jewels',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.white),
        body: Container(child: ProductsGrid()));
  }
}
