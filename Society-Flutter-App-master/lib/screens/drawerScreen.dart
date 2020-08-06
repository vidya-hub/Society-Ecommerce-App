import 'package:flutter/material.dart';
import 'package:society/screens/add_product_screen.dart';


class DrawerScreen extends StatelessWidget
{
  static const routeName = '/DrawerScreen';
  @override
  Widget build(BuildContext context) {

    List<String> mySocietyName = [];

    return Drawer(
        child:Column(
          children: <Widget>[
            AppBar(
              //title: new Text("Navigation Drawer"),
                iconTheme: new IconThemeData(color: Colors.pink),
                backgroundColor: Color.fromRGBO(254, 243, 244, 1.0),
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(backgroundColor: Colors.transparent,child: ClipOval(child: Image.asset("assets/user.png"),),radius: 20,),///Icon(Icons.account_circle,size:26),
              title: Text("My Profile"),
              onTap: null//()=> Navigator.of(context).pushReplacementNamed(AddProductScreen.routeName),

            ),
            mySocietyName.isEmpty
              ?SizedBox(height: 1,)
              :ListView.builder(
                itemBuilder: (context,i)=>
                  Column(
                    children: [
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.business,size:26),
                      title: Text(mySocietyName[i]),
                      //onTap: ()=> Navigator.of(context).pushNamed(''),
                    ),
                  ],
                ),
              itemCount: mySocietyName.length,
            ),
          ],
        )
    );
  }
}