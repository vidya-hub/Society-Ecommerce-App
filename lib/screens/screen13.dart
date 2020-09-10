import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'add_product_screen.dart';
import 'editProduct.dart';
import 'screen16.dart';

class Screen13 extends StatefulWidget {
  final productId;
  Screen13({this.productId});
  @override
  _Screen13State createState() => _Screen13State();
}

String currentgoogleuserid;
final GoogleSignIn googleSignIn = GoogleSignIn();

class _Screen13State extends State<Screen13> {
  @override
  void initState() {
    googleSignIn.signInSilently().then(
      (value) {
        setState(() {
          currentgoogleuserid = value.id;
          get_store(currentgoogleuserid);
        });
        print("this page $currentgoogleuserid");
      },
    ).catchError(
      (error) {
        print(error);
      },
    );
    print(
      Firestore.instance.collection("AddStore").document(currentgoogleuserid),
    );
    // get_store();

    super.initState();
  }

  var storename;
  var store_imgurl;
  var store_cat;
  var store_created;
  var description;
  get_store(id) async {
    var store_details =
        await Firestore.instance.collection("AddStore").document(id).get();
    setState(
      () {
        storename = store_details.data["storeName"];
        print("$storename");
        description = store_details.data["storeDescription"];
        store_imgurl = store_details.data["s_photoUrl"];
        store_cat = store_details.data["selected-category"];
        store_created = store_details.data["createdAt"];
      },
    );
    print(store_imgurl);
  }

  var productdetails = Firestore.instance
      .collection("Product")
      .document(currentgoogleuserid)
      .collection("products")
      .snapshots();

  var url_img =
      "https://images.pexels.com/photos/1236701/pexels-photo-1236701.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.only(top: 30),
                height: MediaQuery.of(context).size.height / 1.5,
                // header image or main image
                child: store_imgurl == null
                    ? Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Center(
                        child: Container(
                          height: 500,
                          width: 600,
                          child: Image.network(store_imgurl),
                        ),
                      ),
              ),
              SizedBox(
                height: 26,
              ),
              Center(
                child: Text(
                  storename == null ? "Loading" : storename,
                  style: TextStyle(fontSize: 26),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                child: Center(
                  child: Text(
                    description == null ? "Loading" : description,
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                padding: EdgeInsets.fromLTRB(17, 0, 22, 0),
              ),
              SizedBox(
                height: 18,
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection("Product")
                          .document(currentgoogleuserid)
                          .collection("products")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Container(
                            child: GridView.count(
                              physics: ClampingScrollPhysics(),
                              childAspectRatio: 3 / 4,
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 10,
                              children: List.generate(
                                snapshot.data.documents.length,
                                (index) {
                                  String getProductId = snapshot
                                      .data.documents[index].data['productId'];
                                  String price = snapshot.data.documents[index]
                                      .data['productPrice'];
                                  String desc = snapshot.data.documents[index]
                                      .data['productDescription'];
                                  String url = snapshot.data.documents[index]
                                      .data['productPhotoUrl'];
                                  String name = snapshot.data.documents[index]
                                      .data['productName'];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Screen16(url,
                                              getProductId, name, desc, price),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      color: Colors.grey[200],
                                      elevation: 4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            height: 140,
                                            width: 150,
                                            child: snapshot
                                                            .data
                                                            .documents[index]
                                                            .data[
                                                        'productPhotoUrl'] !=
                                                    null
                                                ? Image.network(
                                                    snapshot
                                                            .data
                                                            .documents[index]
                                                            .data[
                                                        'productPhotoUrl'],
                                                    height: 100,
                                                    width: 200,
                                                  )
                                                : Center(
                                                    child: Container(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                  ),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            snapshot.data.documents[index]
                                                        .data['productName'] ==
                                                    null
                                                ? "Loading....."
                                                : snapshot.data.documents[index]
                                                    .data['productName'],
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            storename == null
                                                ? "Loading....."
                                                : storename,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            "Rs " +
                                                        snapshot
                                                                .data
                                                                .documents[index]
                                                                .data[
                                                            'productPrice'] ==
                                                    null
                                                ? "Loading....."
                                                : snapshot.data.documents[index]
                                                    .data['productPrice'],
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Center(
                    child: SizedBox(
                      width: 400,
                      height: 50,
                      child: RaisedButton(
                        child: Text(
                          'ADD PRODUCT/SERVICES TO STORE',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddProductScreen()));
                        },
                        color: Colors.green[700],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
