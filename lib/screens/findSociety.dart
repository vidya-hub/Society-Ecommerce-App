import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:society/screens/AddSociety.dart';
import 'package:society/screens/add_product_screen.dart';
import 'dart:convert';

import 'package:society/screens/drawerScreen.dart';

class FindSociety extends StatefulWidget {
  final number;
  FindSociety({this.number});

  static const routeName = '/FindSociety';

  @override
  _FindSocietyState createState() => _FindSocietyState();
}

class _FindSocietyState extends State<FindSociety> {
  bool isInSociety = false;

  @override
  void initState() {
    print("${widget.number} phone no");
    // get_data();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        //title: new Text("Navigation Drawer"),
        iconTheme: new IconThemeData(color: Colors.pink),
        backgroundColor: Color.fromRGBO(254, 243, 244, 1.0),
      ),
      drawer: DrawerScreen(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          //color: Color("#fefafb"),
          color: Color.fromRGBO(254, 243, 244, 1.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showSearch(context: context, delegate: DataSearch());
                },
                child: Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.pink[600],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Search your Society",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Spacer(),
                      VerticalDivider(),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          showSearch(context: context, delegate: DataSearch());
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 12),
              Container(
                child: Text(
                  "Find your society here",
                  style: TextStyle(fontSize: 26),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("OR",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
              SizedBox(
                height: 20,
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddSociety(
                        //  number: widget.number
                          ),
                      ),
                    );
                    // showSearch(context: context, delegate: DataSearch());
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 150,
                        width: 100,
                        child: Image.asset(
                          "assets/add-group.png",
                          //fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "Add your society now!",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> searchNames = ["Shivam society1", "Shivam society 2"];

    return searchNames.isEmpty
        ? ListTile(
            onTap: () {},
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              radius: 15,
              child: ClipOval(
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ),
            title: Text(
              "Add your society ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : ListView.builder(
            itemBuilder: (context, i) => ListTile(
              onTap: () {},
              leading: Container(
                child: CircleAvatar(
                  radius: 70,
                  child: ClipOval(
                    child: Icon(Icons.business),
                  ),
                ),
              ),
              title: Text(searchNames[i]),
            ),
            itemCount: searchNames.length,
          );

    ListTile(
      onTap: () {},
      leading: Container(
        child: CircleAvatar(
          radius: 70,
          child: ClipOval(
            child: Icon(Icons.business),
          ),
        ),
      ),
    );
  }
}
