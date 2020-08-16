import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:society/screens/cart.dart';

class Producttile extends StatefulWidget {
  String product_url;
  String productName, productprice;
  var productid;
  //  mycolor;
  // var onpressed;
  // var isSelected;

  Producttile(
      {@required this.product_url,
      // @required this.onpressed,
      // @required this.isSelected,
      // @required this.mycolor,
      @required this.productName,
      @required this.productprice,
      @required this.productid});

  @override
  _ProducttileState createState() => _ProducttileState();
}

class _ProducttileState extends State<Producttile> {
  TextEditingController editingController = TextEditingController();
  // var isSelected = false;
  // var mycolor = Colors.white;
  // void toggleSelection() {
  //   setState(() {
  //     if (widget.isSelected) {
  //       widget.mycolor = Colors.white;
  //       widget.isSelected = false;
  //     } else {
  //       widget.mycolor = Colors.grey[300];
  //       widget.isSelected = true;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var cachedNetworkImage = CachedNetworkImage(
      imageUrl: widget.product_url,
      height: 150,
      width: 150,
      fit: BoxFit.cover,
    );
    return Container(
      child: SizedBox(
        height: 1000,
        child: Card(
          // color: widget.mycolor,
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
                  onTap: () {
                    print("pressed");
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
