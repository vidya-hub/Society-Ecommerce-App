import 'package:flutter/material.dart';
import 'package:society/screens/selectSociety.dart';

class Screen4 extends StatefulWidget {
  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Image.asset(
              'assets/animation1.gif',
              height: 90,
            ),
            Text(
              "Are you a seller or buyer?",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 350,
              height: 50,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    side: BorderSide(color: Colors.greenAccent[400])),
                child: Text(
                  'I have store, I want to sell',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ),
                onPressed: () {
                   Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SelectSocietyPage()));
                },
                color: Colors.greenAccent[400],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 350,
              height: 50,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    side: BorderSide(color: Colors.teal[800])),
                child: Text(
                  'I want to buy from stores nearby',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SelectSocietyPage()));
                },
                color: Colors.teal[800],
              ),
            ),
            Image.asset(
              'assets/animation2.gif',
              width: 450,
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}