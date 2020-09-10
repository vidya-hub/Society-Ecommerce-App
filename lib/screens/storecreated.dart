import 'package:flutter/material.dart';
import './add_product_screen.dart';
import './screen8.dart';
import '../screens/screen4.dart';

class StorecreatedPage extends StatefulWidget {
  @override
  _StorecreatedPageState createState() => _StorecreatedPageState();
}

class _StorecreatedPageState extends State<StorecreatedPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Screen8(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _value = false;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.green)),
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(
                      Icons.check,
                      size: 60.0,
                      color: Colors.green,
                    )),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Store Created Sucessfully",
                style: TextStyle(
                    color: Colors.black, fontSize: 30.0, letterSpacing: 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
