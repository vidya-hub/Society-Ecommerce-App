import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:society/screens/cart.dart';

class SocietyTile extends StatelessWidget {
  String s_photoUrl, storeName, storeDescription, ownerUserId;
  TextEditingController editingController = TextEditingController();

  int startIndex = 0;
  int endIndex = 11;

  SocietyTile(
      {@required this.s_photoUrl,
      @required this.storeName,
      @required this.storeDescription,
      @required this.ownerUserId});

  @override
  Widget build(BuildContext context) {
    var cachedNetworkImage = CachedNetworkImage(
      imageUrl: s_photoUrl,
      height: 120,
      width: 100,
      fit: BoxFit.fill,
    );
    return FlatButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Cart(id: ownerUserId),
          ),
        );
        // print("$ownerUserId");
        // print("$storeName");
      },
      child: Container(
        color: Colors.black12,
        height: 200,
        child: Column(
          children: [
            Container(
              height: 110,
              width: 200,
              child: cachedNetworkImage,
            ),
            Text(storeName,
                style: new TextStyle(color: Colors.black, fontSize: 18)),
            SizedBox(height: 4),
            Text(storeDescription,
                style: new TextStyle(color: Colors.black, fontSize: 15))
          ],
        ),
      ),
    );
  }
}
