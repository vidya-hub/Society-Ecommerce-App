import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './product_saved.dart';
import '../screens/add_product_screen.dart';
import '../screens/editProduct.dart';
import './orderDetails.dart';

class Screen16 extends StatefulWidget {
  final String mediaUrl,
      productId,
      nameController,
      descController,
      priceController;
  const Screen16(this.productId, this.mediaUrl, this.nameController,
      this.descController, this.priceController);
  @override
  _Screen16State createState() => _Screen16State();
}

final GoogleSignIn googleSignIn = GoogleSignIn();
String currentgoogleuserid;

class _Screen16State extends State<Screen16> {
  String shopName, shopDesc;
  int price = 42000;
  bool _isButtonDisabled = false;
  @override
  void initState() {
    googleSignIn.signInSilently().then(
      (value) {
        setState(() {
          currentgoogleuserid = value.id;
        });
        print("this page $currentgoogleuserid");
      },
    ).catchError(
      (error) {
        print(error);
      },
    );
    setdetails();
    super.initState();
  }

  void setdetails() async {
    var snapshot = await Firestore.instance
        .collection("AddStore")
        .document(currentgoogleuserid)
        .get();
    setState(() {
      shopName = snapshot.data["storeName"];
      shopDesc = snapshot.data["storeDescription"];
    });
  }

  @override
  Widget build(BuildContext context) {
    String mediaImage = widget.mediaUrl;
    String price = widget.priceController;
    String product_name = widget.nameController;
    String shop_name = shopName;
    String prod_description = widget.descController;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: Image.network("$mediaImage"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 26,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 17,
                  ),
                  Text(
                    product_name == null ? "Loading" : product_name,
                    style: TextStyle(fontSize: 26),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    "Rs. " + price == null ? "Loading" : price.toString(),
                    style: TextStyle(fontSize: 26),
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 18,
                  ),
                  Text(
                    shop_name == null ? "Loading" : shop_name,
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 19,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(17, 0, 22, 0),
                  child: Text(
                    prod_description == null ? "Loading" : prod_description,
                    style: TextStyle(height: 1.9, fontSize: 16),
                  )),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                      width: 160,
                      height: 50,
                      child: RaisedButton(
                        child: Text('EDIT'),
                        onPressed: () {
                          print(widget.productId);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProductScreen(
                                    productId: widget.productId,
                                    mediaUrl: widget.mediaUrl,
                                    name: widget.nameController,
                                    desc: widget.descController,
                                    price: widget.priceController)),
                          );
                        },
                        color: Colors.greenAccent,
                      )),
                  SizedBox(
                    width: 160,
                    height: 50,
                    child: RaisedButton(
                        child: Text('OUT OF STOCK'),
                        onPressed: _isButtonDisabled
                            ? null
                            : () {
                                print('google id' + currentgoogleuserid);
                                print(widget.productId);
                                DocumentReference documentReference = Firestore
                                    .instance
                                    .collection('Product')
                                    .document(currentgoogleuserid)
                                    .collection('products')
                                    .document(widget.productId);
                                setState(() =>
                                    _isButtonDisabled = !_isButtonDisabled);
                                documentReference.updateData(
                                  {
                                    'status': 'Out of Stock',
                                  },
                                );
                              },
                        color: Colors.orange[300]),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 13),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: new Container(
                    padding: EdgeInsets.only(left: 4, right: 10),
                    width: MediaQuery.of(context).size.width * 0.96,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductSaved()),
                        );
                      },
                      color: Colors.blueGrey[600],
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "Save Product",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            letterSpacing: 1.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
