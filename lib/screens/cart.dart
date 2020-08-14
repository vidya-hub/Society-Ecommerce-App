import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:society/screens/categories.dart';
import 'package:society/screens/products_of_store.dart';
import 'package:society/screens/screen12.dart';
import 'package:society/screens/welcome.dart';
import 'package:society/utils/widgetCart.dart';
import 'myProducts.dart';

class Cart extends StatefulWidget {
  final id;
  Cart({this.id});
  @override
  _CartState createState() => _CartState();
}

Stream usersStream;
List<String> cartchoices = [
  "All",
  "Boutique",
  "Groceries",
  "Gadgets",
  "Games",
  "Books"
];

int val1 = 1;
int val2 = 1;

class _CartState extends State<Cart> {
  @override
  void initState() {
    print("${widget.id}");
    googleSignIn.signInSilently().then(
      (value) {
        setState(
          () {
            currentgoogleuserid = value.id; // use this
          },
        );
      },
    );
    get_store();
    getData().then(
      (result) {
        setState(
          () {
            usersStream = result;
          },
        );
      },
    );
    super.initState();
  }

  var storename;
  var description;
  getData() async {
    return await await Firestore.instance
        .collection("Product")
        .document(widget.id)
        .collection("products")
        .snapshots();
  }

  get_store() async {
    var store_details = await Firestore.instance
        .collection("AddStore")
        .document(widget.id)
        .get();
    setState(() {
      storename = store_details.data["storeName"];
      description = store_details.data["storeDescription"];
    });
  }

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: new Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              new Container(
                alignment: Alignment.topCenter,
                child: new Text(
                  "$storename",
                  style: new TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  "$description",
                  style: new TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              new SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                // margin: EdgeInsets.all(15.0),
                child: new ListView.builder(
                  itemCount: cartchoices.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 10.0, 40.0, 10.0),
                        child: SizedBox(
                          height: 80,
                          width: 100,
                          child: RaisedButton(
                            autofocus: true,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            onPressed: () {},
                            child: new Text(
                              '${cartchoices.elementAt(i)}',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ));
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.69,
                width: 800,
                child: Container(
                  child: usersStream != null
                      ? SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              StreamBuilder(
                                stream: usersStream,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return CircularProgressIndicator();
                                  } else {
                                    return Column(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GridView.builder(
                                          physics: ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.all(10),
                                          itemCount:
                                              snapshot.data.documents.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 2 / 4,
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 10.0,
                                            crossAxisSpacing: 15.0,
                                          ),
                                          itemBuilder: (context, index) {
                                            return Producttile(
                                              product_url: snapshot
                                                  .data
                                                  .documents[index]
                                                  .data['productPhotoUrl'],
                                              productName: snapshot
                                                  .data
                                                  .documents[index]
                                                  .data['productName'],
                                              productprice: snapshot
                                                  .data
                                                  .documents[index]
                                                  .data['productPrice'],
                                              productid: snapshot
                                                  .data
                                                  .documents[index]
                                                  .data['productId'],
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        )
                      : Container(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
              Padding(padding: EdgeInsets.all(30)),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50,
                    width: wid * 0.95,
                    color: Colors.black,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Screen12(),
                          ),
                        );
                      },
                      color: Colors.black,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text(
                            "Review your Cart",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                new Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                                new Text((val1 + val2).toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17))
                              ])
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
