import 'package:flutter/material.dart';
import 'package:society/screens/buyerorseller.dart';
import 'package:society/screens/screen4.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OtpConfirmedPage extends StatefulWidget {
  @override
  _OtpConfirmedPageState createState() => _OtpConfirmedPageState();
}

class _OtpConfirmedPageState extends State<OtpConfirmedPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Screen4()));
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
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.check,
                      size: 30.0,
                      color: Colors.green,
                    )),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Signed-In",
                style: TextStyle(color: Colors.black, fontSize: 30.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
