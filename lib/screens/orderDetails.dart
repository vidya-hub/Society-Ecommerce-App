import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../utils/widget.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
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
                padding: EdgeInsets.symmetric(horizontal: 50),
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
        body: new TabBarView(children: <Widget>[
          new ListView(
            children: <Widget>[
              Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10)),
                    Text(
                      "Sept 23,2018",
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20)),
                    Text(
                      "Sheet Lakhani",
                      style: textStyle(),
                    ),
                    Padding(padding: EdgeInsets.only(left: 50)),
                    RaisedButton(
                        color: Colors.white,
                        child: Text(
                          "PENDING",
                          style: TextStyle(
                              color: Colors.redAccent[200], fontSize: 20),
                        ),
                        shape: new RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.redAccent[200],
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {}),
                  ],
                ),
                Row(children: <Widget>[
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 3, horizontal: 20)),
                  Text("Paid : Rs 4500", style: pageStyle()),
                ]),
                Padding(padding: EdgeInsets.only(top: 20)),
                Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage("assets/food.jpeg"),
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 15)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage("assets/food.jpeg"),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ]),
                Padding(padding: EdgeInsets.only(top: 20)),
                Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 40)),
                    RaisedButton(
                        color: Colors.white,
                        padding: EdgeInsets.all(15),
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
                        onPressed: () {}),
                    Padding(padding: EdgeInsets.only(left: 20)),
                    RaisedButton(
                        color: Colors.teal[200],
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "ORDER PICKED UP",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {}),
                  ],
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Container(
                  height: 1,
                  width: double.maxFinite,
                  color: Colors.grey,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10)),
                    Text(
                      "Sept 23,2018",
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20)),
                    Text(
                      "Rohini",
                      style: textStyle(),
                    ),
                    Padding(padding: EdgeInsets.only(right: 90)),
                    RaisedButton(
                        color: Colors.white,
                        child: Text(
                          "COMPLETED",
                          style:
                              TextStyle(color: Colors.teal[200], fontSize: 20),
                        ),
                        shape: new RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.teal[200],
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {}),
                  ],
                ),
                Row(children: <Widget>[
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 3, horizontal: 20)),
                  Text("Paid : Rs 2100", style: pageStyle()),
                ]),
                Padding(padding: EdgeInsets.only(top: 20)),
                Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage("assets/food.jpeg"),
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage("assets/food.jpeg"),
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage("assets/food.jpeg"),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ]),
              ]),
            ],
          ),
          new ListView(
            children: <Widget>[
              Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10)),
                    Text(
                      "Sept 18,2018",
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20)),
                    Text(
                      "Rohini's Store",
                      style: textStyle(),
                    ),
                    Padding(padding: EdgeInsets.only(left: 40)),
                    RaisedButton(
                        color: Colors.white,
                        child: Text(
                          "COMPLETED",
                          style:
                              TextStyle(color: Colors.teal[200], fontSize: 20),
                        ),
                        shape: new RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.teal[200],
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {}),
                  ],
                ),
                Row(children: <Widget>[
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 3, horizontal: 20)),
                  Text("Paid : Rs 2100", style: pageStyle()),
                ]),
                Padding(padding: EdgeInsets.only(top: 20)),
                Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage("assets/food.jpeg"),
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage("assets/food.jpeg"),
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage("assets/food.jpeg"),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ]),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Container(
                  height: 1,
                  width: double.maxFinite,
                  color: Colors.grey,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10)),
                    Text(
                      "Sept 18,2018",
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20)),
                    Text(
                      "Rohini's Store",
                      style: textStyle(),
                    ),
                    Padding(padding: EdgeInsets.only(right: 27)),
                    RaisedButton(
                        color: Colors.white,
                        child: Text(
                          "NOT PICKED UP",
                          style: TextStyle(
                              color: Colors.redAccent[200], fontSize: 18),
                        ),
                        shape: new RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.redAccent[200],
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(8)),
                        onPressed: () {}),
                  ],
                ),
                Row(children: <Widget>[
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 3, horizontal: 20)),
                  Text("Paid : Rs 2100", style: pageStyle()),
                ]),
                Padding(padding: EdgeInsets.only(top: 20)),
                Row(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage("assets/food.jpeg"),
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage("assets/food.jpeg"),
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage("assets/food.jpeg"),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ]),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Pickup Details",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    Text(
                      "Shweta Lakhani",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      "Ashmitha Ghosh (+919273846542)",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "904, Christa 2, Apollo DB City",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              ]),
            ],
          ),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(MdiIcons.compassOutline, color: Colors.black),
                title: Text('')),
            BottomNavigationBarItem(
                icon: Icon(MdiIcons.cart, color: Colors.black),
                title: Text('')),
            BottomNavigationBarItem(
                title: Text(
                  'Account',
                  style: TextStyle(color: Colors.black),
                ),
                icon: Icon(
                  MdiIcons.account,
                  color: Colors.black,
                )),
          ],
          currentIndex: selectedIndex,
          fixedColor: Colors.deepPurple,
          onTap: onItemTapped,
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
