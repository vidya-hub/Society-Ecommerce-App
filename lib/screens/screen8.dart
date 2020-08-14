import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/add_store.dart';
import '../screens/orderDetails.dart';
import '../screens/profilepage.dart';
import '../screens/selectSociety.dart';
import '../screens/screen13.dart';
import 'accountPage.dart';
import 'cart.dart';
import 'findSociety.dart';
import './crud.dart';
import './societytiles.dart';

List<String> categories = [
  "All",
  "Boutique",
  "Groceries",
  "Gadgets",
  "Games",
  "Books"
];
List<Widget> _widgetList = [
  Screen8_wid(),
  AddStore(),
  OrderDetails(),
  AccountPage(),
];

int _currentIndex = 0;
bool _search = true;

//import 'package:society/screens/cart.dart';
class Screen8 extends StatefulWidget {
  @override
  _Screen8State createState() => _Screen8State();
}

class _Screen8State extends State<Screen8> {
  @override
  Widget build(BuildContext context) {
    //final prodProvider = Provider.of<Product>(context);
    //final prodList = prodProvider.items;
    double wid = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
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
              title: new Text("Profile",
                  style: new TextStyle(color: Colors.black))),
        ],
      ),
      body: _widgetList[_currentIndex],
    );
  }
}

class Screen8_wid extends StatefulWidget {
  @override
  _Screen8_widState createState() => _Screen8_widState();
}

var _selectedindex;

class _Screen8_widState extends State<Screen8_wid> {
  CrudMethods_store crudMethods = new CrudMethods_store();
  Stream usersStream;

  Widget SocietyCards() {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Container(
        child: usersStream != null
            ? Column(
                children: <Widget>[
                  StreamBuilder(
                    stream: usersStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
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
  void initState() {
    crudMethods.getData().then(
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      // height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(color: Colors.white, height: 40),
            Container(
              height: 75,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(""),
                  _search
                      ? Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              new SizedBox(
                                height: 17,
                              ),
                              Row(children: [
                                Text(
                                  "   Apollo DB City",
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
                                            builder: (context) =>
                                                SelectSocietyPage()));
                                  },
                                  child: new Text(
                                    " (change)",
                                    style: new TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontSize: 18,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ]),
                              Text(
                                "    " + "Indore" + "Nipania ",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                          width: 200,
                          child: TextFormField(
                            decoration: InputDecoration(hintText: "Search..."),
                          ),
                        ),
                  // ....
                  RawMaterialButton(
                    onPressed: () {
                      setState(() {
                        if (_search) {
                          _search = false;
                        } else {
                          _search = true;
                        }
                      });
                    },
                    fillColor: Colors.grey[300],
                    child: Icon(
                      Icons.search,
                      size: 23,
                    ),
                    padding: EdgeInsets.all(8.0),
                    shape: CircleBorder(),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
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
                        onPressed: () {},
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
}
