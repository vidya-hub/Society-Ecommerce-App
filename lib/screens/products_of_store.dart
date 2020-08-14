import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:society/screens/cart.dart';

class Producttile extends StatefulWidget {
  String product_url, productName, productprice, productid;

  Producttile(
      {@required this.product_url,
      @required this.productName,
      @required this.productprice,
      @required this.productid});

  @override
  _ProducttileState createState() => _ProducttileState();
}

class _ProducttileState extends State<Producttile> {
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cachedNetworkImage = CachedNetworkImage(
      imageUrl: widget.product_url,
      height: 150,
      width: 150,
      fit: BoxFit.cover,
    );
    return Container(
      // height: Media,
      child: SizedBox(
        height: 1000,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new Container(
                child: cachedNetworkImage,
                color: Colors.grey,
              ),
              ListTile(
                title: new Text(
                  widget.productName,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18),
                ),
                subtitle: new Text(
                  widget.productprice,
                  textAlign: TextAlign.center,
                ),
                contentPadding: EdgeInsets.all(5.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new InkWell(
                    child: Icon(
                      Icons.arrow_left,
                      color: Colors.black,
                    ),
                    onTap: () {
                      int currentValue = val2;
                      setState(() {
                        currentValue--;
                        val2 = (currentValue >= 0 ? currentValue : 0);
                      });
                    },
                  ),
                  new Text(
                    '$val2',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  new InkWell(
                    child: Icon(
                      Icons.arrow_right,
                      color: Colors.black,
                    ),
                    onTap: () {
                      int currentValue = val2;
                      setState(() {
                        currentValue++;
                        val2 = (currentValue >= 0 ? currentValue : 0);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
