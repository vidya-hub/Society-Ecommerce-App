import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../screens/screen20.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'otpconfirmed.dart';

double subTotal = 0.0;
int quantityy = 0;
var addDt = DateTime.now();
var newFormat = DateFormat("dd-MMMM-y");
int val1 = 1, val2 = 1;
var id;
String postId = Uuid().v4();
List names = [];
List urls = [];
List cartlist = <Widget>[];
List<String> prices = [];
List<int> quentity = [];
var db;
var currentgoogleuserId;
String currentgoogleuserid;
final GoogleSignIn googleSignIn = GoogleSignIn();

class Screen12 extends StatefulWidget {
  List<String> selProducts;
  var sellerId;

  String ownerId;
  String storeName;
  Screen12({this.selProducts, this.sellerId, this.ownerId, this.storeName});
  @override
  _Screen12State createState() => _Screen12State();
}

getTotalPrice(List<int> quentity, List<String> prices) {
  for (int i = 0; i < quentity.length; i++) {
    subTotal = quentity[i] * double.parse(prices[i]);
  }
  print('hellllo');
  print(subTotal);
}

class _Screen12State extends State<Screen12> {
  String storeOwnerName = '...';
  String storeOwnerNumber = '...';
  String storeAddress = '...';
  String storeCity;
  String storeName = '...';

  @override
  void initState() {
    super.initState();
    cartlist = <Widget>[];
    //print(widget.selProducts);
    listbnao();
    getStoreDetails();
    googleSignIn.signInSilently().then(
      (value) {
        setState(() {
          currentgoogleuserid = value.id;
          // setStoreName(currentgoogleuserid);
        });
        print("this page $currentgoogleuserid");
      },
    ).catchError(
      (error) {
        print(error);
      },
    );
  }

  void listbnao() async {
    setState(() {
      id = widget.sellerId;
    });
    for (var item1 in widget.selProducts) {
      quentity.add(1);
      print(quentity);
    }
    // for (int i = 0; i < widget.selProducts.length; i++) {
    int i = 0;

    for (var item in widget.selProducts) {
      // quentity.add(1);
      print('value isss');
      print(quentity[i]);
      db = await Firestore.instance
          .collection("Product")
          .document(id)
          .collection("products")
          .document(item)
          .get();
      print(db.data["productName"]);
      setState(
        () {
          prices.add(db.data["productPrice"]);
          cartlist.add(
            cartItems(
              img_url: db.data["productPhotoUrl"],
              name: db.data["productName"],
              price: db.data["productPrice"],
              vall: quentity[i],
              index: i,
            ),
          );
        },
      );
      i++;
    }

    // print(cartlist);
    print(quentity);
    print(prices);
    setState(() {
      getTotalPrice(quentity, prices);
    });
  }

  var data;
  String get_data(id, String dataname) {
    var dataStart = Firestore.instance
        .collection("Product")
        .document(widget.sellerId)
        .collection("products")
        .document(id)
        .get();
    dataStart.then(
      (value) => {
        setState(
          () {
            data = value.data[dataname];
          },
        ),
      },
    );
    print(data.toString());
    return data.toString();
  }

  getStoreDetails() async {
    var dataStore = await Firestore.instance
        .collection("Users")
        .document(widget.ownerId)
        .get();
    var store = await Firestore.instance
        .collection("AddStore")
        .document(widget.ownerId)
        .get();

    setState(() {
      storeName = store.data["storeName"];
      storeOwnerName = dataStore.data["Name"];
      storeAddress = dataStore.data["full_address"];
      storeOwnerNumber = dataStore.data["Mobile_Number"];
      storeCity = dataStore.data["User_city"];
      print('address: $storeAddress' + ' ,$storeCity');
    });
  }

  var snapshots = Firestore.instance
      .collection("Product")
      .document(id)
      .collection("products")
      .snapshots();

  getQuantity() {
    quantityy = 0;

    for (int i = 0; i < quentity.length; i++) {
      setState(() {
        quantityy = quantityy + quentity[i];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(subTotal);
    int currentValue;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: Colors.black12,
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "From",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "$storeName",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        "$storeOwnerName ($storeOwnerNumber),",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "$storeAddress, $storeCity",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Icon(
                      MdiIcons.whatsapp,
                      color: Colors.green,
                      size: 30,
                    ),
                    Text(
                      "Whatsapp",
                      style: TextStyle(color: Colors.green),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: cartlist,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 50)),
          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 20)),
              Text(
                "Sub Total:",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 180)),
              Text(
                subTotal == null ? '' : subTotal.toString(),
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Align(
            alignment: Alignment.bottomCenter,
            child: new Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.95,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: RaisedButton(
                onPressed: () async {
                  getQuantity();
                  await Firestore.instance
                      .collection("order2")
                      .document(currentgoogleuserid)
                      .collection("Placed")
                      .document(widget.sellerId)
                      .setData(
                    {
                      "storeid": widget.sellerId,
                      // "productId": item.toString(),
                      "date": newFormat.format(addDt).toString(),
                      "quantity": 1.toString(),
                      "status": "",
                      widget.sellerId: widget.selProducts,
                    },
                  );

                  await Firestore.instance
                      .collection("order2")
                      .document(widget.sellerId)
                      .collection("Recieved")
                      .document(currentgoogleuserid)
                      .setData(
                    {
                      "buyerid": currentgoogleuserid,
                      // "productId": item.toString(),
                      "date": newFormat.format(addDt).toString(),
                      "quantity": quantityy.toString(),
                      "status": "pending",
                      currentgoogleuserid: widget.selProducts,
                    },
                  );
                  for (var item in widget.selProducts) {
                    await Firestore.instance
                        .collection("order2")
                        .document(currentgoogleuserid)
                        .collection("Placed")
                        .document(widget.sellerId)
                        .collection("Ordered-Products")
                        .document(item)
                        .setData({
                      "storeid": widget.sellerId,
                      "date": newFormat.format(addDt).toString(),
                      "quantity": quantityy.toString(),
                      "status": "pending",
                      "order-status": "not-picked-up",
                    }).catchError((onError) {
                      print(onError);
                    });
                    await Firestore.instance
                        .collection("order2")
                        .document(widget.sellerId)
                        .collection("Recieved")
                        .document(currentgoogleuserid)
                        .collection("Recieved-Products")
                        .document(item)
                        .setData(
                      {
                        "buyerid": currentgoogleuserid,
                        // "productId": item.toString(),
                        "date": newFormat.format(addDt).toString(),
                        "quantity": quantityy.toString(),
                        "status": "pending",
                        // currentgoogleuserid: widget.selProducts,
                      },
                    );
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtpConfirmedPage(
                          // id:
                          ),
                    ),
                  );
                },
                color: Colors.blueGrey[600],
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Text("CONFIRM ORDER AND PAY",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class cartItems extends StatefulWidget {
  int vall, index;
  cartItems({
    this.currentValue,
    this.img_url,
    this.name,
    this.price,
    this.vall,
    this.index,
  });

  var currentValue = 20, img_url, name, price;

  @override
  _cartItemsState createState() => _cartItemsState();
}

class _cartItemsState extends State<cartItems> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 18)),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.img_url,
                width: 140,
                height: 140,
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 40)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.name, style: TextStyle(fontSize: 18)),
                Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                Text("Rs. ${widget.price}", style: TextStyle(fontSize: 16)),
                Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                //
                Row(
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1.5, color: Colors.red[500]),
                      ),
                      child: new InkWell(
                        child: Icon(
                          Icons.remove,
                        ),
                        onTap: () {
                          if (widget.vall > 1) {
                            setState(() {
                              quentity[widget.index]--;
                              widget.vall--;
                              getTotalPrice(quentity, prices);
                            });
                            print('list');
                            print(quentity);
                            print(widget.vall);
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 15)),
                    new Text(
                      widget.vall.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    Padding(padding: EdgeInsets.only(left: 15)),
                    Container(
                      width: 30,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(width: 1.5, color: Colors.green[500]),
                      ),
                      child: new InkWell(
                        child: Icon(
                          Icons.add,
                        ),
                        onTap: () {
                          if (widget.vall > 0) {
                            setState(() {
                              quentity[widget.index]++;
                              widget.vall++;
                              getTotalPrice(quentity, prices);
                              // val1 = (widget.vall >= 0 ? widget.vall : 0);
                            });

                            print('list');
                            print(quentity);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                //
              ],
            ),
          ],
        ),
      ),
    );
  }
}
