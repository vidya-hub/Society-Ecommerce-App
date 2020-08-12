import './screen8.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './welcome.dart';
import 'screen4.dart';

class Condition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    doo(context);
    return Container(
      width: 0,
      height: 0,
    );
  }

  doo(context) async {
    final _auth = FirebaseAuth.instance;
    final user = await _auth.currentUser();
    //
    //FirebaseUser uss = await FirebaseAuth.instance.currentUser();
    if (user == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomePage(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Screen8(),
        ),
      );
    }
  }
}
