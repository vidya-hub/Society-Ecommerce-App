
import 'package:flutter/material.dart';
import 'package:society/screens/add_product_screen.dart';
import 'package:society/screens/add_store.dart';
import 'package:society/screens/myProducts.dart';

const TextStyle kBottomBarTextStyle = TextStyle(fontFamily: 'PlayfairDisplay');

class HomePage extends StatefulWidget {
  static const String id = '/HomePage';

  HomePage();

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  List<Widget> _widgetList = [
MyProducts(),
AddStore(),
AddProductScreen()

  ];
  
  int _currrentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
//      appBar: _buildAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        //   unselectedItemColor: Color(0xff7E3338),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currrentIndex,
        onTap: (index) {
          setState(() {
            _currrentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            title: Text('Explore', style: kBottomBarTextStyle),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.store,
              ),
              title: Text('My Store', style: kBottomBarTextStyle)),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              title: Text('Profile', style: kBottomBarTextStyle)),
             
        ],
      ),
      body: _widgetList[_currrentIndex],
    );
  }
}

