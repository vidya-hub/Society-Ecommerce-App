import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'add_product_screen.dart';

class Screen13 extends StatefulWidget {
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
                child: Text(
                  description == null ? "Loading" : description,
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.fromLTRB(17, 0, 22, 0),
              ),
              SizedBox(
                height: 18,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("Product")
                    .document(currentgoogleuserid)
                    .collection("products")
                    .snapshots(),
                builder: (context, snapshot) {
                  return Container(
                    child: GridView.count(
                      childAspectRatio: (0.85),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: List.generate(
                        snapshot.data.documents.length,
                        (index) {
                          return Center(
                            child: Container(
                              padding: EdgeInsets.all(0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: snapshot.data.documents[index]
                                                .data['productPhotoUrl'] !=
                                            null
                                        ? Image.network(
                                            snapshot.data.documents[index]
                                                .data['productPhotoUrl'],
                                          )
                                        : Center(
                                            child: Container(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                  ),
                                  SizedBox(
                                    height: 10,
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
                                    height: 8,
                                  ),
                                  Text(
                                    "Rs " +
                                                snapshot.data.documents[index]
                                                    .data['productPrice'] ==
                                            null
                                        ? "Loading....."
                                        : snapshot.data.documents[index]
                                            .data['productPrice'],
                                    style: TextStyle(
                                        fontSize: 17,
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
                },
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
        ),
      ),
    );
  }
}
