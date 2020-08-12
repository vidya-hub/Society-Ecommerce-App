import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:society/screens/add_store.dart';
import 'package:society/screens/orderDetails.dart';
import 'package:society/screens/profilepage.dart';
import '../screens/screen13.dart';
import 'accountPage.dart';
import 'cart.dart';
import 'findSociety.dart';

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

class _Screen8_widState extends State<Screen8_wid> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
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
                              decoration:
                                  InputDecoration(hintText: "Search..."),
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
                        ));
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: new Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5.0),
                    ),
                    card(MediaQuery.of(context).size.width * 0.9, context),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                    ),
                    card(MediaQuery.of(context).size.width * 0.9, context)
                  ],
                ),
              )
            ]));
  }
}

Container card(double width, BuildContext context) {
  return Container(
      height: 300,
      width: width / 2,
      child: Card(
        //elevation: 5,
        child: new Column(children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              },
              child: new Container(
                height: 200,
                width: width / 2,
                color: Colors.grey,
              ),
            ),
//            child: new Image.asset('assets/user.png',
//              height: 200,
//              width: width/2 ,
//              fit: BoxFit.cover,
//            ),
          ),
          new ListTile(
            title: new Text("Shweta Groceries",
                style: new TextStyle(color: Colors.black, fontSize: 18)),
            subtitle: new Text("\nAll the "),
            contentPadding: EdgeInsets.all(5.0),
            // trailing: new FlatButton.icon(onPressed: , icon: Icon(Icons.play_arrow), label: new Text("Play")
          )
        ]),
      ));
}
