import 'package:flutter/material.dart';
import 'package:society/models/products.dart';
import 'package:society/screens/AddSociety.dart';
import 'package:society/screens/accountPage.dart';
import 'package:society/screens/add_product_screen.dart';
import 'package:society/screens/drawerScreen.dart';
import 'package:society/screens/findSociety.dart';
import 'package:society/screens/orderDetails.dart';
import 'package:society/screens/orderPage.dart';
import 'package:society/screens/screen11.dart';
import 'package:society/screens/screen12.dart';
import 'package:society/screens/screen13.dart';
import 'package:society/screens/screen16.dart';
import 'package:society/screens/screen20.dart';
import 'package:society/screens/screen8.dart';
import 'package:society/screens/screen9.dart';
import 'package:society/screens/welcome.dart';
import 'package:society/screens/condition.dart';
import 'package:provider/provider.dart';
import './models/products.dart';

void main() {
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // vidya
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
        home: Condition(),
        routes: {
          FindSociety.routeName : (context) => FindSociety(),
          DrawerScreen.routeName :(context) => DrawerScreen(),
          AddSociety.routeName :(context) => AddSociety(),
         // AddProductScreen.routeName : (Context)=> AddProductScreen(),
        },
      ),
    );
  }
}

