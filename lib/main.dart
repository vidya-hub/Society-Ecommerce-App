import 'package:flutter/material.dart';
import './models/products.dart';
import './screens/AddSociety.dart';

import './screens/drawerScreen.dart';
import './screens/findSociety.dart';
import './screens/welcome.dart';
import 'package:provider/provider.dart';

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
