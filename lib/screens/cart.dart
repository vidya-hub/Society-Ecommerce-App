import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../screens/categories.dart';
import '../screens/products_of_store.dart';
import '../screens/screen12.dart';
import '../screens/welcome.dart';
import '../utils/widgetCart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'myProducts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Cart extends StatefulWidget {
  final id;
  Cart({this.id});
  @override
  _CartState createState() => _CartState();
}

String currentgoogleuserid;
final GoogleSignIn googleSignIn = GoogleSignIn();

List<String> productId_sel = [];

List<int> productId = [];
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
int itemCount = 0;
int items = 0;

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
    super.initState();
  }

  var storename = "Loading";
  var description = "Loading";
  String ownerId;

  get_store() async {
    var store_details = await Firestore.instance
        .collection("AddStore")
        .document(widget.id)
        .get();
    setState(() {
      storename = store_details.data["storeName"];
      description = store_details.data["storeDescription"];
      ownerId = store_details.data["ownerUserId"];
    });
  }

  var isSelected = false;
  var mycolor = Colors.white;
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
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
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
              Center(
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
                height: MediaQuery.of(context).size.height * 0.75,
                width: 800,
                child: Container(
                  child: Firestore.instance
                              .collection("Product")
                              .document(widget.id)
                              .collection("products")
                              .snapshots() !=
                          null
                      ? SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              StreamBuilder(
                                stream: Firestore.instance
                                    .collection("Product")
                                    .document(widget.id)
                                    .collection("products")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return CircularProgressIndicator();
                                  } else {
                                    return Column(
                                      children: [
                                        GridView.builder(
                                          physics: ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.all(10),
                                          itemCount:
                                              snapshot.data.documents.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 4 / 6,
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
              // Padding(padding: EdgeInsets.all(30)),
              Align(
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
                          builder: (context) => Screen12(
                            selProducts: productId_sel,
                            sellerId: widget.id,
                            storeName: storename,
                            ownerId: ownerId,
                          ),
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
                            ])
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

String prod;

class _ProducttileState extends State<Producttile> {
  TextEditingController editingController = TextEditingController();
  var isSelected = false;
  var mycolor = Colors.white;
  String prod = " Add to cart  ";
  void toggleSelection() {
    print(widget.productName);
    if (productId_sel.contains(widget.productid)) {
      setState(() {
        productId_sel.remove(widget.productid);

        itemCount = productId_sel.length;
      });
    } else {
      setState(() {
        productId_sel.add(widget.productid);

        itemCount = productId_sel.length;
      });
    }
    print(productId_sel);
    setState(() {
      if (isSelected) {
        mycolor = Colors.white;
        isSelected = false;
        prod = " Add to cart  ";
      } else {
        mycolor = Colors.grey[400];
        isSelected = true;
        prod = ' Remove ';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var cachedNetworkImage = CachedNetworkImage(
      imageUrl: widget.product_url,
      height: 140,
      width: 150,
      fit: BoxFit.cover,
    );
    return Container(
      child: SizedBox(
        height: 1000,
        child: Card(
          color: mycolor,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new Container(
                padding: EdgeInsets.all(6),
                child: cachedNetworkImage,
                color: mycolor,
              ),
              ListTile(
                onTap: toggleSelection,
                selected: isSelected,
                title: new Text(
                  widget.productName,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 15),
                ),
                subtitle: Column(
                  children: [
                    new Text(
                      widget.productprice,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Container(
                      child: Text(
                        prod,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.green),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
                contentPadding: EdgeInsets.all(5.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
