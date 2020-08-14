import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:society/models/SocietyModel.dart';
import 'package:society/screens/buyerorseller.dart';
import 'package:society/screens/otp.dart';
import 'package:society/screens/otpconfirmed.dart';
import 'package:society/screens/screen4.dart';
import 'package:society/screens/screen8.dart';

final usersRef = Firestore.instance.collection('users');

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

var updatedDt;
var addDt = DateTime.now();
var newFormat = DateFormat("dd-MMMM-y");
var sp;
String currentgoogleuserid;
final GoogleSignIn googleSignIn = GoogleSignIn();

class _WelcomePageState extends State<WelcomePage> {
  static const routeName = '/WelcomePage';
  String verification_id;
  final _phoneController = TextEditingController(text: '');
  SocietyModel societyModel;
  bool _saving = false;

  @override
  void initState() {
    print("inoint");
    super.initState();
    googleSignIn.isSignedIn().then(
          (value) => {
            if (value)
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Screen8(),
                  ),
                )
              }
            else
              {print("else part")}
          },
        );
    // googleSignIn.signInSilently().then(
    //   (value) {
    //     setState(() {
    //       currentgoogleuserid = value.id;
    //     });
    //     print(currentgoogleuserid);
        // handleSignIn(value);
    //   },
    // ).catchError(
    //   (error) {
    //     print(error);
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Container(
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
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 90),
                  child: OutlineButton(
                    splashColor: Colors.grey,
                    onPressed: () async {
                      setState(() {
                        _saving = true;
                      });
                      GoogleSignIn gs = GoogleSignIn(scopes: ['email']);
                      GoogleSignInAccount google_user = await gs.signIn();
                      GoogleSignInAuthentication google_auth =
                          await google_user.authentication;
                      final AuthCredential credential =
                          await GoogleAuthProvider.getCredential(
                              idToken: google_auth.idToken,
                              accessToken: google_auth.accessToken);
                      final AuthResult authResult = await FirebaseAuth.instance
                          .signInWithCredential(credential);
                      final FirebaseUser user = await authResult.user;
                      final sp = await Firestore.instance
                          .collection("Users")
                          .document(google_user.id)
                          .get();
                      print(sp.data);
                      print(sp.exists);
                      if (sp.exists) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Screen8(),
                          ),
                        );
                      } else {
                        await Firestore.instance
                            .collection("Users")
                            .document(google_user.id)
                            .setData(
                          {
                            "date": newFormat.format(addDt),
                            "User_email": user.email,
                            "User_ID": google_user.id,
                            "Society_Id": user.uid,
                          },
                        );
                        setState(() {
                          _saving = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Screen4(
                              id: google_user.id,
                            ),
                          ),
                        );
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    highlightElevation: 0,
                    borderSide: BorderSide(color: Colors.black54, width: 2),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                              image: AssetImage("assets/google-logo.jpg"),
                              height: 35.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Start with Google',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black87,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // handleSignIn(GoogleSignInAccount account) async {
  //   if (account != null) {
  //     print("he is there");
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => Screen8(),
  //       ),
  //     );
  //   } else {
  //     print("he is not there");
  //   }
  // }
}
