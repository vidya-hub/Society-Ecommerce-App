import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:society/screens/selectSociety.dart';
import 'package:society/screens/welcome.dart';

class Screen4 extends StatefulWidget {
  final String id;

  const Screen4({Key key, this.id});
  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser log_user;

  String type;

  @override
  void initState() {
    get_user();
    print("init");
    super.initState();
  }

  void get_user() async {
    final user = await _auth.currentUser();
    try {
      if (user != null) {
        log_user = user;
        print(log_user.phoneNumber);
      } else {
        print("init_else");
        print(user);
        print(user.phoneNumber);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Column(
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
                    type = "seller";
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectSocietyPage(
                                  id: widget.id,
                                  type: type,
                                )));
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
                    type = "buyer";

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectSocietyPage(
                          type: type,
                          id: widget.id,
                        ),
                      ),
                    );
                  },
                  color: Colors.teal[800],
                ),
              ),
              Image.asset(
                'assets/animation2.gif',
                width: 450,
                height: 300,
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                child: Text("Sign-Out"),
                onPressed: () {
                  GoogleSignIn gs = GoogleSignIn(scopes: ['email']);
                  gs.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomePage()));
                  //get_user();
                  print("Signed-out");
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WelcomePage(),
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
