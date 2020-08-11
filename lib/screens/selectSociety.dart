import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:society/models/SocietyModel.dart';
import 'package:society/screens/profilepage.dart';
import 'package:society/screens/welcome.dart';
import 'package:society/utils/citystatelist.dart';

final usersRef = Firestore.instance.collection('users');

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class SelectSocietyPage extends StatefulWidget {
   final String phone_no;
  final String type;
  const SelectSocietyPage({Key key, this.phone_no, this.type});

  @override
  _SelectSocietyPageState createState() => _SelectSocietyPageState();
}

class _SelectSocietyPageState extends State<SelectSocietyPage> {
  String _selectedcity;
  String address;
  final addressController = TextEditingController(text: '');
  String _selectedstate;
  String _selectsociety;
  String society;
  final societyController = TextEditingController(text: '');
  SocietyModel societyModel;


  final _auth = FirebaseAuth.instance;
  FirebaseUser log_user;
  String type;

 @override
  void initState() {
    // get_user();
    // get_id();
    print("init");
    super.initState();
  }

  List<Item> users = <Item>[
    const Item(
      'Add',
      Icon(MdiIcons.plusCircleOutline),
    ),
    const Item(
      'Swetha Jewels',
      Icon(MdiIcons.laserPointer),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Container(
                      width: 80,
                      height: 80,
                      child: Image.asset(
                        "assets/add-group.png",
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      "Select Your Society",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Times new Roman"),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                // width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Select City",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontFamily: "Times new Roman"),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black)),
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: MediaQuery.of(context).size.width * 0.8,
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text(
                      'Please choose a City'), // Not necessary for Option 1
                  value: _selectedcity,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedcity = newValue;
                    });
                  },
                  items: users.map((Item user) {
                                    return DropdownMenuItem<Item>(
                                      value: user,
                                      child: Row(children: <Widget>[
                                        user.icon,
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          user.name,
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16,
                                              fontFamily: "GentiumBasic"),
                                        ),
                                      ]),
                                    );
                                  }).toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                // width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Select Your Society",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontFamily: "Times new Roman")),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black)),
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: MediaQuery.of(context).size.width * 0.8,
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text(
                      'Enter your society'), // Not necessary for Option 1
                  value: _selectsociety,
                  onChanged: (newValue) {
                    setState(() {
                      _selectsociety = newValue;
                    });
                  },
                  items:  users.map((Item user) {
                                    return DropdownMenuItem<Item>(
                                      value: user,
                                      child: Row(children: <Widget>[
                                        user.icon,
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          user.name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                             ),
                                        ),
                                      ]),
                                    );
                                  }).toList(),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
              //   child: Container(
              //     margin: EdgeInsets.symmetric(vertical: 5),
              //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              //     width: MediaQuery.of(context).size.width * 0.8,
              //     decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(5),
              //         border: Border.all(color: Colors.black)),
              //     child: TextFormField(
              //       cursorColor: Colors.black,
              //       // validator: valiadetName,
              //       onSaved: (value) {
              //         society = value;
              //       },
              //       keyboardType: TextInputType.text,
              //       controller: societyController,
              //       decoration: InputDecoration(
              //         border: InputBorder.none,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                // width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Full Address",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontFamily: "Times new Roman")),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    // validator: valiadetName,
                    onSaved: (value) {
                      address = value;
                    },
                    keyboardType: TextInputType.text,
                    controller: addressController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                // width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Select State",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontFamily: "Times new Roman"),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black)),
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: MediaQuery.of(context).size.width * 0.8,
                child: DropdownButton(
                  isExpanded: true,
                  hint: Text('State'), // Not necessary for Option 1
                  value: _selectedstate,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedstate = newValue;
                    });
                  },
                  items: states.map((location) {
                    return DropdownMenuItem(
                      child: Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                width: MediaQuery.of(context).size.width * 0.84,
                height: MediaQuery.of(context).size.height * 0.1,
                // alignment: Alignment.bottomRight,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.grey)),
                  child: Text(
                    "DONE",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Times new Roman",
                        fontSize: 15.0),
                  ),
                  // color: Colors.white,
                  color: Color.fromRGBO(1, 44, 50, 0.8),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage(
                           phone_no: widget.phone_no,

                        )));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
