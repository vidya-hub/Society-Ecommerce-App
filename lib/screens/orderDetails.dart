import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../screens/screen20.dart';
import '../utils/widget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

String currentgoogleuserid;
final GoogleSignIn googleSignIn = GoogleSignIn();
List myorderStoreids = [];
List recievedOrdersids = [];
// List myorderproductid = [];
Map myOrdersPlaced = {};
Map myOrdersRecieved = {};

List myordersWids = <Widget>[];
List recievedOrdersWids = <Widget>[];

class _OrderDetailsState extends State<OrderDetails> {
  bool isLoading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        isLoading = true;
        myordersWids.clear();
        recievedOrdersWids.clear();
      });
      await googleSignIn.signInSilently().then(
        (value) async {
          setState(() {
            currentgoogleuserid = value.id;
            print("this page $currentgoogleuserid");
          });
          await get_my_orders(currentgoogleuserid);
          await get_Recieved_orders(currentgoogleuserid);
          await get_myorder_product();
          await get_orders_recieved_product();
        },
      ).catchError(
        (error) {
          print(error);
        },
      );
      setState(() {
        isLoading = false;
        print("Isloading Done");
      });
    });

    // get_product();

    super.initState();
  }

  Future<void> get_my_orders(id) async {
    // print(id);
    var orders = await Firestore.instance
        .collection("order2")
        .document(id)
        .collection("Placed")
        .orderBy('date', descending: true)
        .getDocuments();

    orders.documents.forEach(
      (element) {
        if (!myorderStoreids.contains(element.documentID)) {
          setState(() {
            myorderStoreids.add(element.documentID);
          });
        } else {
          print("there");
        }
      },
    );
    // print(myorderStoreids);

    for (var item in myorderStoreids) {
      await Firestore.instance
          .collection("order2")
          .document(id)
          .collection("Placed")
          .document(item)
          .get()
          .then(
            (value) => {
              setState(
                () {
                  myOrdersPlaced[item] = value.data[item];
                },
              )

              // print("$item--   ${value.data[item]}"),
            },
          );
    }
    // print(myOrdersPlaced);
  }

  Future<void> get_myorder_product() async {
    print("map of rec    $myOrdersPlaced");
    print("rec_ord_id    $myorderStoreids");
    for (var myorderid in myorderStoreids) {
      for (var productid in myOrdersPlaced[myorderid]) {
        await Firestore.instance
            .collection("Product")
            .document(myorderid)
            .collection("products")
            .document(productid)
            .get()
            .then(
          (value) {
            // print(value.data);
            setState(
              () {
                myordersWids.add(
                  MyOrders(
                    date: value.data["createdAt"],
                    name: value.data["productName"],
                    img_url: value.data["productPhotoUrl"],
                    price: value.data["productPrice"],
                    status: "pending",
                    product_id: myorderid,
                    sellerid: value.documentID,
                  ),
                );
              },
            );
            // MyOrders(),
          },
        );
      }
    }
  }

  Future<void> get_orders_recieved_product() async {
    for (var myorderid in recievedOrdersids) {
      print(myorderid);
      for (var productid in myOrdersRecieved[myorderid]) {
        print(productid);
        await Firestore.instance
            .collection("Product")
            .document(currentgoogleuserid)
            .collection("products")
            .document(productid)
            .get()
            .then(
          (value) {
            // print(value.data);
            // OrdersRecieved(),
            setState(() {
              // print("Id:---- "+myorderid1);
              recievedOrdersWids.add(
                OrdersRecieved(
                  date_r: value.data["createdAt"],
                  name_r: value.data["productName"],
                  img_url_r: value.data["productPhotoUrl"],
                  price: value.data["productPrice"],
                  status: "pending",
                  sellerid: myorderid,
                  product_id: value.data["productId"],
                ),
              );
            });
          },
        );
      }
    }
  }

  Future<void> get_Recieved_orders(id) async {
    // print(re);
    var orders = await Firestore.instance
        .collection("order2")
        .document(id)
        .collection("Recieved")
        .orderBy('date', descending: true)
        .getDocuments();
    orders.documents.forEach(
      (element) {
        if (!recievedOrdersids.contains(element.documentID)) {
          setState(() {
            recievedOrdersids.add(element.documentID);
          });
        } else {
          print("there");
        }
      },
    );
    // print(recievedOrdersids);

    for (var item in recievedOrdersids) {
      Firestore.instance
          .collection("order2")
          .document(id)
          .collection("Recieved")
          .document(item)
          .get()
          .then(
            (value) => {
              setState(
                () {
                  myOrdersRecieved[item] = value.data[item];
                },
              ),
            },
          );
    }
  }

  // get_order_status(currentuserid, sellerid, orderType) async {
  //   String status;
  //   await Firestore.instance
  //       .collection("order2")
  //       .document(currentuserid)
  //       .collection("Placed")
  //       .document(sellerid)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       status = value.data["status"];
  //     });
  //     // print(
  //     //   "status ---${value.data["status"]}",
  //     // );
  //   });
  //   return status.toString();
  //   // .getDocuments();
  // }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
              ),
              Text("Order Details",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 22),
                  textAlign: TextAlign.center)
            ],
          ),
          bottom: new TabBar(
              indicatorColor: Colors.black,
              indicatorWeight: 3,
              tabs: <Widget>[
                new Tab(
                  child: Container(
                    child: Text("ORDERS RECEIVED",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15)),
                  ),
                ),
                new Tab(
                  child: Container(
                    child: Text("MY ORDERS",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15)),
                  ),
                ),
              ]),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : new TabBarView(children: <Widget>[
                SingleChildScrollView(
                  child: recievedOrdersWids.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 40),
                              child: Image.asset('assets/no_orders.jpeg'),
                            ),
                          ],
                        )
                      : new Column(
                          children: recievedOrdersWids, //OrdersRecieved
                        ),
                ),
                SingleChildScrollView(
                  child: myordersWids.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 40),
                              child: Image.asset('assets/no_orders.jpeg'),
                            ),
                          ],
                        )
                      : new Column(
                          children: myordersWids, //my orders
                        ),
                ),
              ]),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class MyOrders extends StatefulWidget {
  var date = "";
  var name = "";
  var img_url = "";
  var price = "";
  var sellerid = "";
  var product_id = "";
  var status = "";

  MyOrders({
    this.date,
    this.name,
    this.img_url,
    this.price,
    this.status,
    this.sellerid,
    this.product_id,
  });

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  String myorder_status;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print(currentgoogleuserid);
      print(widget.sellerid);
      print(widget.product_id);
      setState(() {
        isLoading = true;
      });
      await myOrder_status();
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> myOrder_status() async {
    print("Hello User");
    DocumentSnapshot snapshot = await Firestore.instance
        .collection("order2")
        .document(currentgoogleuserid)
        .collection("Placed")
        .document(widget.product_id)
        .collection("Ordered-Products") //myorderStoreids
        .document(widget.sellerid)
        .get()
        .then((value) {
      value.data.forEach((key, value) {
        print("Key: " + key.toString() + "Value: " + value.toString());
      });
      print(value.data["status"]);
      setState(() {
        myorder_status = value.data["status"].toString();
      });
    });

    print("My order Status displayed " + myorder_status);
  }

  @override
  Widget build(BuildContext context) {
    //print("Myorder status:"+ statusV);
    // myOrder_status();
    // String statusV = myorder_status;
    return SizedBox(
      height: 250,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        elevation: 4,
        child: Container(
          margin: EdgeInsets.all(5),
          height: 220,
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                //Padding(padding: EdgeInsets.only(left: 15, top: 45)),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "${widget.date}",
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.grey[400],
            ),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 6, left: 10, right: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: Image.network(
                          widget.img_url,
                          fit: BoxFit.contain,
                          width: 110,
                          height: 140,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, left: 10),
                          child: Text(
                            "${widget.name}",
                            style: textStyle(),
                          ),
                        ),
                      ],
                    ),
                    Row(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 10, left: 10),
                        child: Text("Paid : Rs ${widget.price}",
                            style: pageStyle()),
                      )
                    ]),
                    Row(
                      children: [
                        FlatButton(
                          color: Colors.white,
                          child: Text(
                            myorder_status != null ? myorder_status : " ",
                            style: TextStyle(
                                color: myorder_status == 'Completed'
                                    ? Colors.teal[200]
                                    : Colors.redAccent[200],
                                fontSize: 20),
                          ),
                          shape: new RoundedRectangleBorder(
                              side: BorderSide(
                                  color: myorder_status == 'Completed'
                                      ? Colors.teal[200]
                                      : Colors.redAccent[200],
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: null,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

class OrdersRecieved extends StatefulWidget {
  var date_r;
  var name_r;
  var img_url_r;
  var price;
  var status;
  var sellerid;
  var product_id;
  OrdersRecieved(
      {this.date_r,
      this.img_url_r,
      this.name_r,
      this.price,
      this.status,
      this.sellerid,
      this.product_id});

  @override
  _OrdersRecievedState createState() => _OrdersRecievedState();
}

class _OrdersRecievedState extends State<OrdersRecieved> {
  bool _isPressed = false;
  bool _orderPicked = false;
  String status_value;

  @override
  void initState() {
    super.initState();
    retrive_status();
  }

  retrive_status() async {
    DocumentSnapshot snapshot = await Firestore.instance
        .collection("order2")
        .document(currentgoogleuserid)
        .collection("Recieved")
        .document(widget.sellerid)
        .collection("Recieved-Products")
        .document(widget.product_id)
        .get();
    setState(() {
      status_value = snapshot.data["status"].toString();
    });

    print("Status displayed " + status_value);
  }

  @override
  Widget build(BuildContext context) {
    String statusValue = status_value;
    print("This is status:" + statusValue);
    return SizedBox(
      height: 300,
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        elevation: 4,
        child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //Padding(padding: EdgeInsets.only(left: 15, top: 45)),

                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "${widget.date_r}",
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey[400],
              ),
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 5, left: 10, right: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            child: Image.network(
                              widget.img_url_r,
                              fit: BoxFit.contain,
                              width: 110,
                              height: 140,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10, top: 20),
                              child: Text(
                                "${widget.name_r}",
                                style: textStyle(),
                              ),
                            ),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text("Paid : Rs ${widget.price}",
                                    style: pageStyle()),
                              )
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FlatButton(
                              color: Colors.white,
                              child: Text(
                                statusValue == null ? ' ' : statusValue,
                                // "Completed",
                                style: TextStyle(
                                    color: statusValue == 'Completed'
                                        ? Colors.teal[200]
                                        : Colors.redAccent,
                                    fontSize: 18),
                              ),
                              shape: new RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: statusValue == 'Completed'
                                          ? Colors.teal[200]
                                          : Colors.redAccent,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(6)),
                              onPressed: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "CANCEL",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      shape: new RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.redAccent[200],
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: _isPressed
                          ? null
                          : () {
                              retrive_status();
                              Firestore.instance
                                  .collection("order2")
                                  .document(currentgoogleuserid)
                                  .collection("Recieved")
                                  .document(widget.sellerid)
                                  .collection("Recieved-Products")
                                  .document(widget.product_id)
                                  .updateData(
                                {
                                  "status": "Cancelled",
                                },
                              );
                              Firestore.instance
                                  .collection("order2")
                                  .document(widget.sellerid)
                                  .collection("Placed")
                                  .document(currentgoogleuserid)
                                  .collection("Ordered-Products")
                                  .document(widget.product_id)
                                  .updateData(
                                {
                                  "status": "Cancelled",
                                },
                              );

                              setState(
                                () => _isPressed = !_isPressed,
                              );
                              if (_isPressed == true) {
                                print("True");
                              } else {
                                print("Disabled");
                              }
                            }),
                  Padding(padding: EdgeInsets.only(left: 14)),
                  RaisedButton(
                    color: Colors.teal[200],
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "ORDER PICKED UP",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: _orderPicked
                        ? null
                        : () {
                            retrive_status();
                            Firestore.instance
                                .collection("order2")
                                .document(currentgoogleuserid)
                                .collection("Recieved")
                                .document(widget.sellerid)
                                .collection("Recieved-Products")
                                .document(widget.product_id)
                                .updateData(
                              {
                                "status": "Completed",
                              },
                            );
                            Firestore.instance
                                .collection("order2")
                                .document(widget.sellerid)
                                .collection("Placed")
                                .document(currentgoogleuserid)
                                .collection("Ordered-Products")
                                .document(widget.product_id)
                                .updateData(
                              {
                                "status": "Completed",
                              },
                            );
                            setState(() => _orderPicked = !_orderPicked);
                          },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
