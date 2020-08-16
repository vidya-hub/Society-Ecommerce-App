import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:society/screens/welcome.dart';
import '../screens/add_store.dart';
import '../screens/orderDetails.dart';
import '../screens/selectSociety.dart';
import '../screens/screen13.dart';
import 'accountPage.dart';
import './societytiles.dart';

List<String> categories = [
  "All",
  "Boutique",
  "Groceries",
  "Gadgets",
  "Games",
  "Books"
];

int _currentIndex = 0;
bool _search = true;
bool nostore = true;
var catValue = "All";

class Screen8 extends StatefulWidget {
  @override
  _Screen8State createState() => _Screen8State();
}

var currentgoogleuserid;
final GoogleSignIn googleSignIn = GoogleSignIn();

class _Screen8State extends State<Screen8> {
  List<Widget> _widgetList = [
    Screen8_wid(),
    AddStore(),
    OrderDetails(),
    AccountPage(),
  ];

  Future<bool> _pressBack() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you want to close this app?'),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _pressBack,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(
              () {
                _currentIndex = index;
              },
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.card_travel, color: Colors.black),
              title: new Text(
                "Buy",
                style: new TextStyle(color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store, color: Colors.black),
              title: new Text(
                "My Store",
                style: new TextStyle(color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.format_list_bulleted,
                color: Colors.black,
              ),
              title: new Text(
                "My Order",
                style: new TextStyle(color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              title: new Text(
                "Profile",
                style: new TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        body: _widgetList[_currentIndex],
      ),
    );
  }
}

class Screen8_wid extends StatefulWidget {
  @override
  _Screen8_widState createState() => _Screen8_widState();
}

var _selectedindex;
Stream stream_all = Firestore.instance.collection("AddStore").snapshots();

Stream stream_cat = Firestore.instance
    .collection("AddStore")
    .where("selected-category", isEqualTo: catValue)
    .snapshots();

class _Screen8_widState extends State<Screen8_wid> {
  String societyName = "loading...";
  String cityName = "loading...";


  Widget SocietyCards() {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Container(
        child: stream_all != null
            ? Column(
                children: <Widget>[
                  StreamBuilder(
                    stream: (catValue == "All") ? stream_all : stream_cat,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Column(
                          children: [
                            GestureDetector(
                              child: GridView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(10),
                                itemCount: snapshot.data.documents.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15.0,
                                  crossAxisSpacing: 15.0,
                                ),
                                itemBuilder: (context, index) {
                                  // print(index);
                                  return SocietyTile(
                                    s_photoUrl: snapshot.data.documents[index]
                                        .data['s_photoUrl'],
                                    storeName: snapshot.data.documents[index]
                                        .data['storeName'],
                                    storeDescription: snapshot
                                        .data
                                        .documents[index]
                                        .data['selected-category'],
                                    ownerUserId: snapshot.data.documents[index]
                                        .data['ownerUserId'],
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              )
            : Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(color: Colors.white, height: 10),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Row(
                            children: [
                              Text(
                                "$societyName",
                                style: new TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  //change address
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SelectSocietyPage(),
                                    ),
                                  );
                                },
                                child: new Text(
                                  "  (change)",
                                  style: new TextStyle(
                                    color: Colors.lightBlueAccent,
                                    fontSize: 18,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text("$cityName"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "     Top Item Categories",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 55,
              // margin: EdgeInsets.all(15.0),
              child: new ListView.builder(
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int i) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      child: RaisedButton(
                        //autofocus: true,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        onPressed: () async {
                          setState(
                            () {
                              catValue = categories[i];
                              stream_cat = Firestore.instance
                                  .collection("AddStore")
                                  .where("selected-category",
                                      isEqualTo: catValue)
                                  .snapshots();
                            },
                          );
                          await Firestore.instance
                              .collection("AddStore")
                              .where("selected-category", isEqualTo: catValue)
                              .getDocuments()
                              .then(
                                (value) => {
                                  print(value.documents),
                                },
                              );
                        },
                        child: new Text('${categories.elementAt(i)}'),
                      ),
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            SocietyCards(),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    googleSignIn.signInSilently().then((value) => {
          print(value.id),
          setDetails(value.id),
        });
    super.initState();
  }

  setDetails(currentgoogleuserid) async {
    print(currentgoogleuserid);
    var snapshot = await Firestore.instance
        .collection("Users")
        .document(currentgoogleuserid)
        .get();
    setState(() {
      societyName = snapshot.data["society_name"];
      cityName = snapshot.data["User_city"];
    });
    // print(societyName);
    // print(cityName);
  }
}
