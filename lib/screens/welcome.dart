import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:society/screens/otp.dart';
import 'package:society/screens/otpconfirmed.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  static const routeName = '/WelcomePage';
  String _number, verification_id;
  final _phoneController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 150.0),
                    child: Container(
                      width: 100,
                      height: 100,
                      child: new Image.asset("assets/fast-food.png",
                          height: 125, width: 125, fit: BoxFit.fill),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 50.0),
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                child: Text(
                  "Buy items from from stores in your society and sell your items and services to people from your society",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontFamily: "Times new Roman",
                    // fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black)),
                child: TextFormField(
                  textAlign: TextAlign.center,

                  cursorColor: Colors.black,
                  // validator: valiadetName,
                  onSaved: (value) {
                    _number = value;
                  },
                  // keyboardType: TextInputType.numberWithOptions(
                  //     signed: true, decimal: true),

                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: "ENTER YOUR PHONE NUMBER",
                    hintStyle: TextStyle(),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 25),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: MediaQuery.of(context).size.width * 0.93,
                height: MediaQuery.of(context).size.height * 0.1,
                // alignment: Alignment.bottomRight,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.grey)),
                  child: Text(
                    "PROCEED",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Times new Roman",
                        fontSize: 15.0),
                  ),
                  // color: Colors.white,
                  color: Color.fromRGBO(1, 44, 50, 0.8),
                  onPressed: () {
                    verify(_phoneController.text);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> verify(phone_no) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) async {
      print(authResult.providerId);
       await Firestore.instance
          .collection(phone_no)
          .document("demodata")
          .setData({"data": "demodata"});        
      print("verified");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpConfirmedPage(),
        ),
      );
    };
    final PhoneVerificationFailed failed = (AuthException excep) {
      print("failed");
      print("${excep.message}");
      print("${excep.code}");
    };
    final PhoneCodeSent smssent = (String verId, [int forceresend]) {
      this.verification_id = verId;
      print("sms is sent");
      print(verId);
      print(verification_id);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Otp(
            phone_no: _phoneController.text,
            ver_code: verification_id,
          ),
        ),
      );
    };
    final PhoneCodeAutoRetrievalTimeout auto_timeout = (String verId) {
      this.verification_id = verId;
      print("timeout");
      print(verId);
    };

    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone_no,
      timeout: const Duration(seconds: 60),
      verificationCompleted: verified,
      verificationFailed: failed,
      codeSent: smssent,
      codeAutoRetrievalTimeout: auto_timeout,
    );
  }
}
