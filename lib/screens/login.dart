import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './otp.dart';

final _formKey = GlobalKey<FormState>();
final _key = GlobalKey<ScaffoldState>();

class Login extends StatelessWidget {
  final TextEditingController _mobilenumcontroller =
      new TextEditingController();
  final TextEditingController _namecontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.redAccent.shade200,
              Colors.pinkAccent.shade200
            ])),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                new Container(
                  alignment: Alignment.center,
                  height: 150,
                  width: 150,
                  child: new Image.asset("assets/fast-food.png",
                      height: 125, width: 125, fit: BoxFit.fill),
                ),
                new SizedBox(
                  height: 20.000,
                ),
                Center(
                  child: new Text(
                    "LOGIN",
                    style: new TextStyle(
                        fontSize: 25,
                        decoration: TextDecoration.underline,
                        color: Colors.white),
                  ),
                ),
                new SizedBox(
                  height: 8.0,
                ),
                new Text(
                  "Enter your Name and Mobile Number to proceed",
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
                new SizedBox(
                  height: 30.0,
                ),
                Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.transparent,
                      border: Border.all(color: Colors.white, width: 0.5)),
                  child: Row(children: [
                    new CircleAvatar(
                      radius: 25.00,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.supervised_user_circle,
                        color: Colors.redAccent,
                      ),
                    ),
                    Expanded(
                      child: new TextFormField(
                        textAlign: TextAlign.center,
                        controller: _namecontroller,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            labelText: "User Name",
                            labelStyle:
                                TextStyle(fontSize: 20, color: Colors.white),
                            contentPadding:
                                EdgeInsets.fromLTRB(70, 0.0, 100, 0.0)),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.transparent,
                      border: Border.all(color: Colors.white, width: 0.5)),
                  child: Row(
                    children: <Widget>[
                      new CircleAvatar(
                        radius: 25.00,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.mobile_screen_share,
                          color: Colors.redAccent,
                        ),
                      ),
                      Expanded(
                        child: new TextFormField(
                          textAlign: TextAlign.center,
                          controller: _mobilenumcontroller,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              labelText: "Mobile number",
                              labelStyle:
                                  TextStyle(fontSize: 20, color: Colors.white),
                              contentPadding:
                                  EdgeInsets.fromLTRB(67, 0.0, 100, 0.0)),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                new SizedBox(
                  height: 42.000,
                ),
                SizedBox(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: new RaisedButton(
                    onPressed: () {
                      // if(_formKey.currentState.validate()){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> Otp()));}
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: new Text(
                      "PROCEED",
                      style: new TextStyle(
                        fontSize: 20,
                        color: Colors.redAccent,
                      ),
                    ),
                    color: Colors.white,
                  ),
                ),
                new SizedBox(
                  height: 20.0,
                ),
                new InkWell(
                  child: new Center(
                    child: Text("Skip for now!",
                        style: new TextStyle(color: Colors.white)),
                  ),
                  onTap: () {
                    print("//skip and jump to main screen");
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
