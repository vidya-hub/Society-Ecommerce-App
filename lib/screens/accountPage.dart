import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,

        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.shopping_basket),
            title: new Text('Buy'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.store),
            title: new Text('My Store'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('My Orders'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Account'))
        ],
      ),
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
                        "assets/dummyprofile.jpeg",
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
                  print("Clicked");
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
                  print("Clicked");
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
                  print("Clicked");
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
