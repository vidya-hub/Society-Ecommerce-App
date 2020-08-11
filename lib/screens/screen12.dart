import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../screens/screen20.dart';
import '../utils/widgetCart.dart';

class Screen12 extends StatefulWidget {
  @override
  _Screen12State createState() => _Screen12State();
}

int val1 = 1, val2 = 5;

class _Screen12State extends State<Screen12> {
  @override
  Widget build(BuildContext context) {
    int currentValue;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.black12,
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Row(
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "From",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Shweta Lakhani",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        "Ashmitha Ghosh (+919273846542)",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "904, Christa 2, Apollo DB City",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ]),
                Padding(padding: EdgeInsets.only(left: 38)),
                Column(
                  children: <Widget>[
                    Icon(
                      MdiIcons.whatsapp,
                      color: Colors.green,
                      size: 40,
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
          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 20)),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  image: AssetImage("assets/food1.jpeg"),
                  width: 140,
                  height: 140,
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 40)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Blouse Fitting", style: TextStyle(fontSize: 18)),
                  Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                  Text("Rs 200", style: TextStyle(fontSize: 16)),
                  Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                  //
                  Row(
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(width: 1.5, color: Colors.red[500]),
                        ),
                        child: new InkWell(
                          child: Icon(
                            Icons.remove,
                          ),
                          onTap: () {
                            currentValue = val1;
                            setState(() {
                              currentValue--;
                              val1 = (currentValue >= 0 ? currentValue : 0);
                            });
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 15)),
                      new Text(
                        "$val1",
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
                            currentValue = val1;
                            setState(() {
                              currentValue++;
                              val1 = (currentValue >= 0 ? currentValue : 0);
                            });
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
          ),
          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 20)),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  image: AssetImage("assets/food1.jpeg"),
                  width: 140,
                  height: 140,
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 40)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Blouse Fitting", style: TextStyle(fontSize: 18)),
                  Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                  Text("Rs 200", style: TextStyle(fontSize: 16)),
                  Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(width: 1.5, color: Colors.red[500]),
                        ),
                        child: new InkWell(
                          child: Icon(
                            Icons.remove,
                          ),
                          onTap: () {
                            currentValue = val2;
                            setState(() {
                              currentValue--;
                              val2 = (currentValue >= 0 ? currentValue : 0);
                            });
                          },
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 15)),
                      new Text(
                        "$val2",
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
                            currentValue = val2;
                            setState(() {
                              currentValue++;
                              val2 = (currentValue >= 0 ? currentValue : 0);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 50)),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 20)),
              Text(
                "Sub Total",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 180)),
              Text(
                "Rs 2700",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          new Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            height: 50,
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Details()),
                );
              },
              color: Colors.blueGrey[600],
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Text("CONFIRM ORDER AND PAY",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
