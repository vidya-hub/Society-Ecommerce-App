import 'package:flutter/material.dart';
import 'package:society/screens/welcome.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

List cartList = ["Blouse Fitting", "Hand Jewellery"];

var addDt = DateTime.now();

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    googleSignIn.signInSilently().then(
      (value) {
        setState(() {
          currentgoogleuserid = value.id; // use this code
        });
        print("this page $currentgoogleuserid");
      },
    ).catchError(
      (error) {
        print(error);
      },
    );
    print("inoint");
    super.initState();
    googleSignIn.signInSilently().then(
      (value) {
        setState(() {
          currentgoogleuserid = value.id; //use this id
        });
        print(currentgoogleuserid);
      },
    ).catchError(
      (error) {
        print(error);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Container(height: 70),
              new Container(
                color: Colors.grey.shade200,
                width: MediaQuery.of(context).size.width,
                child: new Column(
                  children: <Widget>[
                    new Text(
                      "From",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    new Text(
                      "Shweta Jewels",
                      style: new TextStyle(
                          color: Colors.lightBlueAccent, fontSize: 14),
                    ),
                    new Text(
                      "Ashmita Ghosh (+91xxxxxxxx)\n904, Christa 2, Apollo DB City",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              new SizedBox(
                height: 14,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: cartList.length,
                itemBuilder: (context, i) {
                  return Container(
                    margin: EdgeInsets.all(5.0),
                    height: 150,
                    child: Card(
                      elevation: 10,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 0.0, left: 5.0),
                            child: Container(
                                margin: EdgeInsets.all(5),
                                width: 120.0,
                                height: 150.0,
                                color: Colors.grey.shade200
//    child: Image.asset(
//    ,
//    fit: BoxFit.cover,
//    ),
                                ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                cartList[i],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                "Rs. 2500",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 19.0,
                                ),
                              ),
                              SizedBox(height: 7.5),
                              new Text(
                                "Qty",
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                              SizedBox(height: 2.5),
                              new Row(
                                children: <Widget>[
                                  new IconButton(
                                      icon: Icon(
                                        Icons.arrow_left,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        //decrement value
                                      }),
                                  new Text(
                                    '5',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  new IconButton(
                                    icon: Icon(
                                      Icons.arrow_right,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      //decrement value
                                    },
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 100,
            width: wid,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(
                        "Sub Total",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      new Text(
                        "Rs. 5000",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: wid * 0.95,
                  color: Colors.black,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OrderPage()));
                    },
                    color: Colors.black,
                    child: new Text(
                      "Confirm Order and Pay",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
