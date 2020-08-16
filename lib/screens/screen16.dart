import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:society/screens/add_product_screen.dart';
import 'package:society/screens/editProduct.dart';

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
              Container(
                height: MediaQuery.of(context).size.height / 1.5,
                child: Image.network(
                    "https://cdn0.weddingwire.in/emp/fotos/5/4/3/1/png-jewelles21_15_205431-1568861691.jpg"),
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
                    product_name==null?"Loading":product_name,
                    style: TextStyle(fontSize: 26),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    "Rs " + price==null?"Loading":price.toString(),
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
                    shop_name==null?"Loading":shop_name,
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
                    prod_description==null?"Loading":prod_description,
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
                                    productId: widget.productId)),
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
                              print('google id'+currentgoogleuserid);
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
                      color: Colors.orange[300]
                    ),
                  ),
                ],
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
