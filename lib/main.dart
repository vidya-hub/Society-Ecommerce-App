import 'package:flutter/material.dart';
import 'package:society/models/products.dart';
import 'package:society/screens/AddSociety.dart';

import 'package:society/screens/drawerScreen.dart';
import 'package:society/screens/findSociety.dart';
import 'package:society/screens/welcome.dart';
import 'package:provider/provider.dart';
import './models/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Products(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Society',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.amber,
          fontFamily: "Gilroy",
        ),
        home: WelcomePage(),
        routes: {
          FindSociety.routeName: (context) => FindSociety(),
          DrawerScreen.routeName: (context) => DrawerScreen(),
          AddSociety.routeName: (context) => AddSociety(),
        },
      ),
    );
  }
}
