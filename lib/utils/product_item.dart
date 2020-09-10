import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
 
class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
   
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        
         child: Image(image: NetworkImage(product.imageUrl)),
        footer: Container(
          color: Colors.black12,
          margin: EdgeInsets.only(top: 10),
          child: Column(children: <Widget>[
            Text(product.title, style:  TextStyle(fontSize: 15),),
            Text('Rs ${product.price.toString()}')
          ],)
        ),
      ),
    );
  }
}
