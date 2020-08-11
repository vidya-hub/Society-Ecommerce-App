import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../screens/screen20.dart';
import '../utils/widgetCart.dart';

class Screen12 extends StatefulWidget {
  @override
  _Screen12State createState() => _Screen12State();
}

class _Screen12State extends State<Screen12> {

  int _n = 0;
void add() {
  setState(() {
    _n++;
  });
}

void minus() {
  setState(() {
    if (_n != 0) 
      _n--;
  });
}
  @override
  Widget build(BuildContext context) {
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
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 12, right: 12),

                          decoration:
                              myBoxDecoration(),
                              child:GestureDetector(
                                onTap: minus,
                               
                          child: Text(
                            "-",
                            style: TextStyle(fontSize: 25.0),
                          ),
                        ),
                      ),
                        Padding(padding: EdgeInsets.only(left: 15)),
                        Text(
                          '$_n',
                          style: TextStyle(fontSize: 18),
                        ),
                        Padding(padding: EdgeInsets.only(left: 15)),
                         Container(
                          padding: const EdgeInsets.only(left: 12, right: 12),

                          decoration:
                              myBox2Decoration(),
                              child:GestureDetector(
                                onTap:
                                  add, //       <--- BoxDecoration here
                          child: Text(
                            "+",
                            style: TextStyle(fontSize: 25.0),
                          ),
                        ),
                         )
                      ],
                    )
                  ])
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
                          padding: const EdgeInsets.only(left: 12, right: 12),

                          decoration:
                              myBoxDecoration(),
                              child:GestureDetector(
                                onTap: minus,
                               
                          child: Text(
                            "-",
                            style: TextStyle(fontSize: 25.0),
                          ),
                        ),
                      ),
                        Padding(padding: EdgeInsets.only(left: 15)),
                        Text(
                          '$_n',
                          style: TextStyle(fontSize: 18),
                        ),
                        Padding(padding: EdgeInsets.only(left: 15)),
                         Container(
                          padding: const EdgeInsets.only(left: 12, right: 12),

                          decoration:
                              myBox2Decoration(),
                              child:GestureDetector(
                                onTap:
                                  add, //       <--- BoxDecoration here
                          child: Text(
                            "+",
                            style: TextStyle(fontSize: 25.0),
                          ),
                        ),
                         )
                      ],
                    )
                  ]),
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
              )),
        ],
      ),
    );
  }
}
