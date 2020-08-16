import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import './selectSociety.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'profilepage.dart';
import './welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountPage extends StatefulWidget {
  var number;
  AccountPage({this.number});
  @override
  _AccountPageState createState() => _AccountPageState();
}

final _auth = FirebaseAuth.instance;
FirebaseUser log_user;

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    googleSignIn.signInSilently().then(
      (value) {
        setState(() {
          currentgoogleuserid = value.id;
          imgurl = value.photoUrl;
          set_data(currentgoogleuserid);
        });
        print("from this    $currentgoogleuserid");
      },
    ).catchError(
      (error) {
        print(error);
      },
    );

    super.initState();
  }

  void set_data(id) async {
    var data = await Firestore.instance.collection("Users").document(id).get();
    setState(() {
      name = data.data["Name"];
      number = data.data["Mobile_Number"];
      societyname = data.data["society_name"];
    });
  }

  String name = "loading...";
  String number = "loading...";
  String imgurl = "https://i.stack.imgur.com/34AD2.jpg";
  String societyname = "loading...";

  bool _sending = false;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _sending,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 30.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 140,
                        width: 140,
                        child: Image(
                          image: NetworkImage(imgurl),
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                        height: 10,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Times New Roman"),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            societyname,
                            style: TextStyle(
                                fontSize: 12.0, fontFamily: "Times New Roman"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(30, 30, 0, 0),
                        child: Icon(
                          Icons.edit,
                          color: Colors.blueAccent,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: "Times New Roman",
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                        child: Container(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectSocietyPage(),
                      ),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(30, 30, 0, 0),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
                        child: Text(
                          "Store Address",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: "Times New Roman",
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                        child: Container(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      _sending = true;
                    });
                    // final _auth = FirebaseAuth.instance;
                    // _auth.signOut();
                    GoogleSignIn gs = GoogleSignIn();
                    gs.signOut();
                    print(
                      gs.isSignedIn(),
                    );
                    print(true);
                    setState(() {
                      _sending = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomePage(),
                      ),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(30, 30, 0, 0),
                        child: Icon(
                          Icons.exit_to_app,
                          color: Colors.red,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: "Times New Roman",
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
