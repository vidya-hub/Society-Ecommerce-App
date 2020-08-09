import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:society/screens/otpconfirmed.dart';

final _formKey = GlobalKey<FormState>();

class Otp extends StatelessWidget {
  final String phone_no;
  final String ver_code;
  const Otp({
    Key key,
    this.phone_no,
    this.ver_code,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController _otpcontroller = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 150,
                  width: 150,
                  child: Image.asset("assets/Icon awesome-key.png",
                      color: Color.fromRGBO(1, 44, 50, 0.6),
                      height: 150,
                      width: 150,
                      fit: BoxFit.fill),
                ),
                SizedBox(
                  height: 10.000,
                ),
                Center(
                  child: Text(
                    "Confirm your OTP",
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.5)),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _otpcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "ENTER YOUR OTP NUMBER",
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      contentPadding: EdgeInsets.fromLTRB(70, 0.0, 100, 0.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: RaisedButton(
                    onPressed: () {
                      FirebaseAuth.instance.currentUser().then((user) {
                        if (user != null) {
                          print("otppage if con");
                          print(user.phoneNumber);
                          print(user.uid);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpConfirmedPage(),
                            ),
                          );
                        } else {
                          print("else condition");
                          // Navigator.of(context).pop();
                          print(_otpcontroller.text);
                          print(ver_code);
                          AuthCredential phoneAuthCredential =
                              PhoneAuthProvider.getCredential(
                                  verificationId: ver_code,
                                  smsCode: _otpcontroller.text);
                          FirebaseAuth.instance
                              .signInWithCredential(phoneAuthCredential)
                              .then(
                                (user) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OtpConfirmedPage(),
                                  ),
                                ).catchError(
                                  (e) => print(e),
                                ),
                              );
                          // signin(ver_code, _otpcontroller.text);
                        }
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      "CONFIRM",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    // color: Colors.white,
                    color: Color.fromRGBO(1, 44, 50, 0.8),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Didn't recieve your OTP?",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    InkWell(
                      child: Text("Resend!",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(1, 44, 50, 0.8))),
                      onTap: () {
                        print("//skip and jump to main screen");
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
