import 'package:flutter/material.dart';
import '../main.dart';
import './selectSociety.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'profilepage.dart';
import './welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountPage extends StatefulWidget {
  var number;
  AccountPage({this.number});
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  //   void initState() {
  //   print("${widget.number} phone no");
  //   get_data();
  //   super.initState();
  // }

  // final _store = Firestore.instance.collection("users");

  // get_data() async {
  //   var _data = await _store.document(widget.number).snapshots();

  //   await for (var datastream in _data) {
  //     setState(() {
  //       address = datastream["address"];
  //       state = datastream["state"];
  //       society_name = datastream["societyname"];
  //     });
  //     print(address);
  //     print(state);
  //     print(society_name);
  //     Address(address, state, society_name, MediaQuery.of(context).size.width,
  //         context);
  //   }
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
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
                      child: Image.asset(
                        "assets/dummyprofile.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Shweta K",
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Times New Roman"),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "+9145411121154",
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
                  final _auth = FirebaseAuth.instance;
                  _auth.signOut();
                  print(true);
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
    );
  }
}
