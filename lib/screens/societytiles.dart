import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../screens/cart.dart';

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
      child: Card(
        color: Colors.grey[200],
        elevation: 5,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              padding: EdgeInsets.all(5),
              height: 140,
              width: 200,
              child: cachedNetworkImage,
            ),
            Flexible(
              child: Text(storeName,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: 4),
            Text(storeDescription,
                style: new TextStyle(color: Colors.black, fontSize: 13))
          ],
        ),
      ),
    );
  }
}
