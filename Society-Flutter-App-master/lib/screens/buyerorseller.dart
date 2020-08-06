import 'package:flutter/material.dart';
import 'package:society/screens/AddSociety.dart';
import 'package:society/screens/categories.dart';
import 'package:society/screens/selectSociety.dart';

class BuyerOrSellerPage extends StatefulWidget {
  @override
  _BuyerOrSellerPageState createState() => _BuyerOrSellerPageState();
}

class _BuyerOrSellerPageState extends State<BuyerOrSellerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Container(
                      color: Colors.grey[200],
                      width: 80,
                      height: 80,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      "Are You a seller os a buyer ?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Times new Roman"),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.1,
                // alignment: Alignment.bottomRight,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.grey)),
                  child: Text(
                    "Enter Your Phone Number",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Times new Roman",
                        fontSize: 15.0),
                  ),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ),
              Container(
                // margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.1,
                // alignment: Alignment.bottomRight,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.grey)),
                  child: Text(
                    "Enter Your Phone Number",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Times new Roman",
                        fontSize: 15.0),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SelectSocietyPage()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
